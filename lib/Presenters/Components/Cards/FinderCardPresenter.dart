import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/Models/DetailFinderCardFormation.dart';
import 'package:findpairs/Models/FinderCardFormation.dart';
import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Cards/FinderCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:findpairs/Utils/SoundManager.dart';
import 'package:flutter/services.dart';

class FinderCardPresenter extends BaseComponentPresenter{

  final Stream<List<int>> stackedCardStream;
  final StreamSink<List<int>> boardCardSink;
  final StreamSink<int> cardPairedSink;
  final StreamSink<int> increaseScore;
  final StreamSink<int> reduceScore;
  final StreamSink<double> updateRatioSink;
  final StreamSink<int> lifeConfigurationSink;
  StreamController<int> _cardValueController = StreamController();
  StreamController<Map<String,int>> _cardChangeValueController = StreamController.broadcast();
  StreamController<Map<String,int>> _scoreAnimationController = StreamController.broadcast();
  StreamController<bool> _restrictionController = StreamController.broadcast();

  FinderCardView _view;
  FinderCardFormation _finderAssets;
  FinderSumaryScore _summary;
  List<int> _boardCards;
  List<int> _stackedCards;
  bool _isNeedInitiate = true;

  FinderCardPresenter({this.stackedCardStream, this.boardCardSink, this.cardPairedSink, this.increaseScore, this.reduceScore, this.updateRatioSink, this.lifeConfigurationSink}){
    _summary = FinderSumaryScore();
    stackedCardStream.listen(onListenStackedStreamCard);
    cardValueStream.listen(onListenCardValue);
  }

  FinderCardView get view => _view;
  set setView(FinderCardView vw){
    _view = vw;
  }

  FinderCardFormation get finderAssets => _finderAssets;
  set setFinderAsset(List<dynamic> data){
    _finderAssets = FinderCardFormation.fromJson(data);
  }

  List<int> get boardCards => _boardCards;

  Stream<int> get cardValueStream => _cardValueController.stream;
  StreamSink<int> get cardValueSink => _cardValueController.sink;

  Stream<Map<String,int>> get cardChangeValueStream => _cardChangeValueController.stream;
  StreamSink<Map<String,int>> get cardChangeValueSink => _cardChangeValueController.sink;

  StreamSink<Map<String,int>> get scoreAnimationSink => _scoreAnimationController.sink;
  Stream<Map<String,int>> get scoreAnimationStream => _scoreAnimationController.stream;

  StreamSink<bool> get restrictionCardSink => _restrictionController.sink;
  Stream<bool> get restrictionCardStream => _restrictionController.stream;

  @override
  void initiateData()async{
    super.initiateData();
    await _summary.getScoreFromStore();
    await configureFormation();
    configureCardBoard();
    view.notifyState();
  }

  configureFormation() async{
    if(_finderAssets == null){
      _finderAssets = FinderCardFormation.fromJsonAndScore(jsonDecode(await rootBundle.loadString("assets/json/Finder.json")), _summary.score);
    }
  }

  onListenStackedStreamCard(List<int> stck){
    if(_stackedCards == null){
      _stackedCards = List();
    }else{
      _stackedCards.clear();
    }
    _stackedCards.addAll(stck);
    if(_isNeedInitiate){
      initiateData();
      _isNeedInitiate = false;
    }
  }

  configureCardBoard(){
    if(_boardCards == null){
      _boardCards = List();
    }else{
      _boardCards.clear();
    }
    Random rand = Random();
    if(_stackedCards.length > _finderAssets.currentCardFormation.total){
      _boardCards.add(_stackedCards.last);
      for(int i= 0; i < _finderAssets.currentCardFormation.total - 1;i++){
        int val = _stackedCards[rand.nextInt(_stackedCards.length)];
        while(_boardCards.contains(val)){
          val = _stackedCards[rand.nextInt(_stackedCards.length)];
        }
        _boardCards.add(val);
      }
    }else{
      _boardCards.addAll(_stackedCards);
      double currentRatio = 1;
      while(currentRatio > _finderAssets.currentCardFormation.ratio){
        int idx = rand.nextInt(_boardCards.length - 1);
        if(_stackedCards.last != boardCards[idx]){
          _boardCards.removeAt(idx);
        }
        currentRatio = CommonUtil.instance.getRatio(_boardCards, _stackedCards);
      }

      for(int i= _boardCards.length; i < _finderAssets.currentCardFormation.total; i++){
        _boardCards.add(CommonUtil.instance.getUniqueRandom(
          max: 32,
          reference: boardCards
        ));
      }
    }
    _boardCards.shuffle();
    boardCardSink.add(_boardCards);
  }

  reconfigAfterPaired(int pairedVal) async{
    // _summary.getScoreFromStore();
    // _finderAssets.setCurrentFormationByScore(_summary.score);
    // if(_finderAssets.currentCardFormation.total > _boardCards)
    
    int index = _boardCards.indexOf(pairedVal);
    Map<String,int> dataChange = Map();
    if(_stackedCards.length - 1 > _boardCards.length){
      // ratio must 1
      if(_boardCards.contains(_stackedCards[_stackedCards.length - 2])){
        //execution when boardcard have value same as last stacked
        Random rand = Random();
        if(index >= 0 ){
          dataChange['old'] = _boardCards[index];
          int nxt = _stackedCards[rand.nextInt(_stackedCards.length - 2)];
          while(_boardCards.contains(nxt)){
            nxt = _stackedCards[rand.nextInt(_stackedCards.length - 2)];
          }
          _boardCards[index] = nxt;
          dataChange['new'] = _boardCards[index];
        }
      }else{
        //execute when boardCard have no same value with last stacked card
        if(index >= 0){
          dataChange['old'] = _boardCards[index];
          _boardCards[index] = _stackedCards[_stackedCards.length - 2];
          dataChange['new'] = _boardCards[index];
        }else{
          //probabably not gonna happen
          Random rand = Random();
          dataChange['old'] = _boardCards[index];
          _boardCards[rand.nextInt(_boardCards.length)] = _stackedCards[_stackedCards.length - 2];
          dataChange['new'] = _boardCards[index];
        }
      }
    }else{
      //boardcard greater than stacked 
      if(index >= 0){
        dataChange['old'] = _boardCards[index];
        if(_boardCards.contains(_stackedCards[_stackedCards.length - 2])){
          print("boardCard contains next last stack");
          _boardCards[index] = CommonUtil.instance.getUniqueRandom(
            max : 32,
            reference: boardCards
          );
        }else{
          print("boardCard not contains next last stack");
          _boardCards[index] = _stackedCards[_stackedCards.length - 2];
        }
        dataChange['new'] = _boardCards[index];
      }
    }
    await expandingBoardCard(dataChange);
    boardCardSink.add(_boardCards);
  }


  onListenCardValue(int val) async{
    FinderSumaryScore score = FinderSumaryScore();
    print("pairing card : "+ _stackedCards.last.toString()+" : "+val.toString());
    String bc = "";
    for(int i= 0; i < boardCards.length; i++){
      bc+=_boardCards[i].toString()+", ";
    }
    await score.getScoreFromStore();
    print("boardCard value : "+bc);
    await score.getCorrectMoveFromStore();
    if(_stackedCards.last == val){
      //paired
      score.setTotalCorrect = score.totalCorrect + 1;
      score.setCorrectMoveToStore();
      SoundManager.manager.play(
        filename: "cheers.mp3",
        player: FindPairsApp.of(view.currentContext()).presenter.particleSound
      );
      increaseScore.add(3);
      animationDamage(3, val);
      reconfigAfterPaired(val);
      cardPairedSink.add(val);
      // view.notifyState();
    }else{
      //notPaired
      await score.getLifeFromStore();
      score.setLife = score.life - 1;
      if(score.life == 0){
        await score.reconfigureLife();
        animationDamage(-1, val);
        reduceScore.add(1);
        lifeConfigurationSink.add(score.life);
      }else{
        lifeConfigurationSink.add(-1);
        await score.setLifeToStore();
      }
    }
    await score.getTotalMoveFromStore();
    score.setTotalMove = score.totalMove + 1;
    await score.setTotalMoveToStore();
    score.updateRatio();
    updateRatioSink.add(score.ratio);
  }

  animationDamage(int score, int val){
    Map<String,int> data = {
      "score" : score,
      "val" : val
    };
    scoreAnimationSink.add(data);
  }

  expandingBoardCard(Map<String,int> dataChange) async{
    FinderSumaryScore score = FinderSumaryScore();
    await score.getScoreFromStore();
    DetailFinderCardFormation form = _finderAssets.getDetailFormationByScore(score.score);
    print("total board : "+form.total.toString()+" with min score =" + form.minScore.toString()+" & reference score = "+score.score.toString());
    if(boardCards.length  < form.total){
       Random rand = Random();
      for(int i = boardCards.length; i < form.total; i++){
        if(_stackedCards.length - 1 > _boardCards.length){
          if(!boardCards.contains(_stackedCards[_stackedCards.length - 2])){
            boardCards.add(_stackedCards[_stackedCards.length - 2]);
          }else{
            int index = 0;
            int nxt = rand.nextInt(_stackedCards.length - 1);
            while(boardCards.contains(_stackedCards[nxt])  && (index < _stackedCards.length - 1)){
              nxt = rand.nextInt(_stackedCards.length - 1);
              index++;
            }

            if(boardCards.contains(_stackedCards[nxt])){
              boardCards.add(CommonUtil.instance.getUniqueRandom(
                max: 32,
                reference: boardCards
              ));
            }else{
              boardCards.add(_stackedCards[nxt]);
            }
          }
        }else{
          boardCards.add(CommonUtil.instance.getUniqueRandom(
            max: 32,
            reference: boardCards
          ));
        }
      }
      print("expanding board");
      _finderAssets.setCurrentFormationByScore(score.score);
      Future.delayed(
        const Duration(milliseconds: 700),
        view.notifyState
      );
    }else{
      cardChangeValueSink.add(dataChange);
    }
  }
  
  forceRestrictionTapAllCard(){
    restrictionCardSink.add(true); 
  }

  forceOpeningTapAllCard(){
    restrictionCardSink.add(false);
  }

  void dispose(){
    _cardValueController.close();
    _cardChangeValueController.close();
    _scoreAnimationController.close();
    _restrictionController.close();
  }
}