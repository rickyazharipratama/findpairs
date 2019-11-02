import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:findpairs/Models/FinderCardFormation.dart';
import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Cards/StackedCardsView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:flutter/services.dart';

class StackedCardsPresenter extends BaseComponentPresenter{

  final StreamSink<List<int>> stackedSinker;
  final Stream<List<int>> boardCardStream;
  final Stream<int> cardPaired;
  StreamController<int> _destroyCardController = StreamController<int>.broadcast();
  StreamController<bool> _refillCardController = StreamController<bool>();
  StackedCardsView _view;
  List<int> _stackedCards;
  List<int> _boardCards;
  StackedCardsPresenter({this. stackedSinker, this.cardPaired, this.boardCardStream}){
    cardPaired.listen(onListenCardPaired);
    refillCardStream.listen(onListenRefillCard);
    boardCardStream.listen(onListenBoardCardStream);
  }

  StackedCardsView get view => _view;
  set setView(StackedCardsView vw){
    _view = vw;
  }

  List<int> get stackedCards => _stackedCards;
  List<int> get boardCards => _boardCards;

  StreamSink<int> get destroyCardSink => _destroyCardController.sink;
  Stream<int> get destroyCardStream => _destroyCardController.stream;

  StreamSink<bool> get refillCardSink => _refillCardController.sink;
  Stream<bool> get refillCardStream => _refillCardController.stream;

  @override
  void initiateData() {
    super.initiateData();
    configureStackedCards();
    view.notifyState();
  }

  configureStackedCards(){
    if(_stackedCards == null){
      _stackedCards = List();
    }else{
      _stackedCards.clear();
    }
    for(int i=0; i < 5; i++){
      _stackedCards.add(CommonUtil.instance.getUniqueRandom(
        max: 32,
        reference: _stackedCards
      ));
    }
    stackedSinker.add(_stackedCards);
  }

  onListenCardPaired(int val){
    //must remove last stacked card and insert into first stacked card
    print("listinening val card paired : "+val.toString());
    print("stacked Card Length : "+stackedCards.length.toString());
    String stval = "";
    for(int i=0; i < stackedCards.length;i ++){
      stval+= stackedCards[i].toString()+",";
    }
    print("val stack : "+stval);
    stackedCards.removeLast();
    stval = "";
    for(int i=0; i < stackedCards.length;i ++){
      stval+= stackedCards[i].toString()+",";
    }
    print("after remove stack : "+stval);
    destroyCardSink.add(val);
  }

  onListenRefillCard(bool isval) async{
    if(isval){
      Random rand = Random();
      print("card length : "+boardCards.length.toString());
      if(stackedCards.length - 1 > boardCards.length){
        stackedCards.insert(0, CommonUtil.instance.getUniqueRandom(
          max: 32,
          reference: stackedCards
        ));
      }else{
        //it's must be reference by board card and ratio
        FinderSumaryScore score = FinderSumaryScore();
        await score.getScoreFromStore();
        FinderCardFormation formation = FinderCardFormation.fromJsonAndScore(jsonDecode(await rootBundle.loadString("assets/json/Finder.json")),score.score);
        double currentRatio = CommonUtil.instance.getRatio(boardCards, stackedCards);
  
        if(currentRatio >= formation.currentCardFormation.ratio){
          stackedCards.insert(0, CommonUtil.instance.getUniqueRandom(
            max: 32,
            reference: stackedCards
          ));
        }else{
          List<int> tmpVal = List();
          boardCards.forEach((val){
            if(!stackedCards.contains(val)){
              tmpVal.add(val);
            }
          });
          if(tmpVal.length > 0){
            stackedCards.insert(0, tmpVal[rand.nextInt(tmpVal.length)]);
          }else{
            stackedCards.insert(0, rand.nextInt(32));
          }
        }
      }
      stackedSinker.add(stackedCards);
      view.notifyState();     
    }
  }

  onListenBoardCardStream(List<int> boardCard){
    if(this._boardCards == null){
      this._boardCards = List();
    }else{
      this._boardCards.clear();
    }
    this._boardCards.addAll(boardCard);
  }

  void dispose(){
    _destroyCardController.close();
    _refillCardController.close();
  }
}