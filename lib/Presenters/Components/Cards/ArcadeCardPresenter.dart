import 'dart:async';
import 'dart:math';

import 'package:findpairs/Models/ArcadeCardValue.dart';
import 'package:findpairs/Models/ArcadeSetting.dart';
import 'package:findpairs/PresenterViews/Components/Cards/CardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/ArcadeUtils.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/material.dart';

class ArcadeCardPresenter extends BaseComponentPresenter{
  
  CardView _view ;
  StreamController<int> _flipBack = StreamController.broadcast();
  StreamController<ArcadeCardValue> _selectedCard = StreamController();
  StreamController<bool> _restrictStream = StreamController.broadcast();
  StreamController<ArcadeTimer> _arcadeTimer = StreamController.broadcast();
  StreamController<bool> _lifeControl = StreamController();
  List<ArcadeCardValue> _selectedCards = List();
  // default score will reduce
  int _stages;
  String _episode;
  int stageScore = 100;
  ArcadeSetting _setting;
  List<ArcadeCardValue> _cardsValue;


  CardView get view => _view;
  set setView(CardView vw){
    _view = vw;
  }

  List<ArcadeCardValue> get selectedCards => _selectedCards;

  Stream<int> get flipBack => _flipBack.stream;
  Stream<bool> get restrictFlip => _restrictStream.stream;
  StreamSink<ArcadeCardValue> get selectedCardSinker => _selectedCard.sink;

  ArcadeSetting get setting => _setting;
  int get stages => _stages;
  String get episode => _episode;

  List<ArcadeCardValue> get cardsValue => _cardsValue;

  StreamSink<ArcadeTimer> get arcadeTimerSinker => _arcadeTimer.sink;
  Stream<ArcadeTimer> get arcadeTimerStream => _arcadeTimer.stream;

  StreamSink<bool> get lifeSinker => _lifeControl.sink;
  Stream<bool> get lifeStream => _lifeControl.stream;

  ArcadeCardPresenter(int stg, String ep){
    _stages = stg;
    _episode = ep;
  }

  @override
  void initiateData() async{
    super.initiateData();
    _selectedCard.stream.listen(addSelectedCard);
    ArcadeUtils utils = ArcadeUtils(episode);
    _setting = await utils.getArcadeSetting(stages.toString());
    _cardsValue = List();
    for(int i = 0; i < 2; i++){
      for(int j= 0;j < _setting.uniqueCard;j++){
        _cardsValue.add(ArcadeCardValue((_setting.uniqueCard * i) + j,j.toString()));
      }
    }
    arcadeTimerStream.listen(timeIsUp);
    view.notifyState();
  }
  

  ArcadeCardValue getAvailableCardValue(){
    List<ArcadeCardValue> available = _cardsValue.where((val)=> !val.isAlreadySelected).toList();
    if(available.length > 1){
      Random rnd = Random();
      int rand = rnd.nextInt(available.length - 1);
      _cardsValue[_cardsValue.indexOf(available[rand])].setAlreadySelected = true;
      return available[rand];
    }
    _cardsValue[_cardsValue.indexOf(available[0])].setAlreadySelected = true;
    return available[0];
  }

  addSelectedCard(ArcadeCardValue card) async{
    debugPrint("selected card = "+card.value);
    selectedCards.add(card);
    if(selectedCards.length >= 2){
      _restrictStream.add(true);
      if(isCardPaired()){
        //should animate becasue  card is paired
        Timer(const Duration(milliseconds: 500),(){
          selectedCards.clear();
          _restrictStream.add(false);
        });
      }else{
        for( int i = 0; i < selectedCards.length; i++){
          Timer(Duration(milliseconds: 500 + (i * 150)),() async{
            debugPrint("iterasi : "+ i.toString());
            await flippingBackCard(selectedCards[i].key);
            if(i+1 == selectedCards.length){
              selectedCards.clear();
              _restrictStream.add(false);
            }
          });
        }
        setting.setLife = setting.life - 1;
        lifeSinker.add(true);
        if(setting.life == 0){
          arcadeTimerSinker.add(ArcadeTimer.onTimeMustStop);
          _restrictStream.add(true);
          Timer(Duration(milliseconds: 400),() async{
            ArcadeAction act =  await view.showNegativeDialog();
            negativeActionDecider(act);
          });
        }
      }
    }
  }

  bool isCardPaired(){
    if(selectedCards[0].value == selectedCards[1].value){
      return true;
    }
    return false;
  }

  // call it when not pairs
  Future<void> flippingBackCard(int val) async{
    _flipBack.add(val);
  }

   //for time is up
   void timeIsUp(ArcadeTimer type) async{
     if(type == ArcadeTimer.onTimeUp){
      ArcadeAction act =  await view.showNegativeDialog();
      negativeActionDecider(act);
     }
   }

  negativeActionDecider(ArcadeAction act){
    if(act == ArcadeAction.retryGame){
      //should initiateData again
      reInitiateGame();
    }else if(act == ArcadeAction.exitGame){
      view.closeView();
    }else{
      view.closeView();
    }
  }

  reInitiateGame() async{
    _cardsValue.forEach((val) async{
      print("reinitiate card");
      await flippingBackCard(val.key);
    });
    selectedCards.clear();
    ArcadeUtils utils = ArcadeUtils(episode);
    _setting = await utils.getArcadeSetting(stages.toString());
    if(_cardsValue != null){
      _cardsValue.clear();
    }else{
      _cardsValue = List();
    }
    for(int i = 0; i < 2; i++){
      for(int j= 0;j < _setting.uniqueCard;j++){
        _cardsValue.add(ArcadeCardValue((_setting.uniqueCard * i) + j,j.toString()));
      }
    }
    _restrictStream.add(false);
    view.notifyState();
  }

  dispose(){
    _flipBack.close();
    _selectedCard.close();
    _restrictStream.close();
    _arcadeTimer.close();
    _lifeControl.close();
  }
}