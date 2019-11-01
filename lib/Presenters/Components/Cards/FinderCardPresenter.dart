import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:findpairs/Models/FinderCardFormation.dart';
import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Cards/FinderCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:flutter/services.dart';

class FinderCardPresenter extends BaseComponentPresenter{

  final Stream<List<int>> stackedCardStream;
  final StreamSink<List<int>> boardCardSink;
  final StreamSink<int> cardPairedSink;
  final StreamSink<int> increaseScore;
  final StreamSink<int> reduceScore;
  final StreamSink<double> updateRatioSink;
  StreamController<int> _cardValueController = StreamController();
  StreamController<Map<String,int>> _cardChangeValueController = StreamController.broadcast();

  FinderCardView _view;
  FinderCardFormation _finderAssets;
  FinderSumaryScore _summary;
  List<int> _boardCards;
  List<int> _stackedCards;
  bool _isNeedInitiate = true;

  FinderCardPresenter({this.stackedCardStream, this.boardCardSink, this.cardPairedSink, this.increaseScore, this.reduceScore, this.updateRatioSink}){
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
        _boardCards.removeAt(rand.nextInt(_boardCards.length - 1));
        currentRatio = CommonUtil.instance.getRatio(_boardCards, _stackedCards);
      }

      for(int i= _boardCards.length - 1 ; i < _finderAssets.currentCardFormation.total; i++){
        int val = rand.nextInt(32);
        while(_boardCards.contains(val)){
          val = rand.nextInt(32);
        }
        _boardCards.add(val);
      }
    }
    _boardCards.shuffle();
    boardCardSink.add(_boardCards);
  }

  reconfigAfterPaired(int pairedVal){
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
      Random rand = Random();
      if(index >= 0){
        dataChange['old'] = _boardCards[index];
        _boardCards[index] = rand.nextInt(32);
        dataChange['new'] = _boardCards[index];
      }
    }
    cardChangeValueSink.add(dataChange);
    boardCardSink.add(_boardCards);
  }


  onListenCardValue(int val) async{
    FinderSumaryScore score = FinderSumaryScore();
    print("pairing card : "+ _stackedCards.last.toString()+" : "+val.toString());
    String bc = "";
    for(int i= 0; i < boardCards.length; i++){
      bc+=_boardCards[i].toString()+", ";
    }
    print("boardCard value : "+bc);
    await score.getCorrectMoveFromStore();
    if(_stackedCards.last == val){
      //paired
      score.setTotalCorrect = score.totalCorrect + 1;
      score.setCorrectMoveToStore();
      reconfigAfterPaired(val);
      increaseScore.add(3);
      cardPairedSink.add(val);
      // view.notifyState();
    }else{
      //notPaired
      
    }
    await score.getTotalMoveFromStore();
    score.setTotalMove = score.totalMove + 1;
    await score.setTotalMoveToStore();
    score.updateRatio();
    updateRatioSink.add(score.ratio);
  }

  void dispose(){
    _cardValueController.close();
    _cardChangeValueController.close();
  }
}