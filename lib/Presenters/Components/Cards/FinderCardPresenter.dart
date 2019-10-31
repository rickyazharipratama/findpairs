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

  FinderCardView _view;
  FinderCardFormation _finderAssets;
  FinderSumaryScore _summary;
  List<int> _boardCards;
  List<int> _stackedCards;

  FinderCardPresenter({this.stackedCardStream, this.boardCardSink}){
    _summary = FinderSumaryScore();
    stackedCardStream.listen(onListenStackedStreamCard);
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
    initiateData();
  }

  configureCardBoard(){
    if(_boardCards == null){
      _boardCards = List();
    }else{
      _boardCards.clear();
    }
    Random rand = Random();
    if(_stackedCards.length > _finderAssets.currentCardFormation.total){
      for(int i= 0; i < _finderAssets.currentCardFormation.total;i++){
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
  }

  reconfigAfterPaired(int pairedVal){
    // _summary.getScoreFromStore();
    // _finderAssets.setCurrentFormationByScore(_summary.score);
    // if(_finderAssets.currentCardFormation.total > _boardCards)
    int index = _boardCards.firstWhere((val) => val == pairedVal);
    if(_stackedCards.length >= _boardCards.length){
      // ratio must 1
      if(_boardCards.contains(_stackedCards[_stackedCards.length - 1])){
        //execution when boardcard have value same as last stacked
        Random rand = Random();
        if(index >= 0 ){
          _boardCards[index] = _stackedCards[rand.nextInt(_stackedCards.length - 1)];
        }
      }else{
        //execute when boardCard have no same value with last stacked card
        if(index >= 0){
          _boardCards[index] = _stackedCards.last;
        }else{
          //probabably not gonna happen
          Random rand = Random();
          _boardCards[rand.nextInt(_boardCards.length)] = _stackedCards.last;
        }
      }
    }else{
      //boardcard greater than stacked
      Random rand = Random();
      if(index >= 0){
        _boardCards[index] = rand.nextInt(32);
      }
    }
    boardCardSink.add(_boardCards);
  }
}