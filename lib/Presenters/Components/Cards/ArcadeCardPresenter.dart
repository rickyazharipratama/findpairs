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
  StreamController<String> _flipBack = StreamController.broadcast();
  StreamController<String> _selectedCard = StreamController();
  StreamController<bool> _restrictStream = StreamController.broadcast();
  StreamController<ArcadeTimer> _arcadeTimer = StreamController.broadcast();
  StreamController<bool> _lifeControl = StreamController();
  List<String> _selectedCards = List();
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

  List<String> get selectedCards => _selectedCards;

  Stream<String> get flipBack => _flipBack.stream;
  Stream<bool> get restrictFlip => _restrictStream.stream;
  StreamSink<String> get selectedCardSinker => _selectedCard.sink;

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
        _cardsValue.add(ArcadeCardValue(j.toString()));
      }
    }
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

  addSelectedCard(String card) async{
    debugPrint("selected card = "+card);
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
            await flippingBackCard(selectedCards[i]);
            if(i+1 == selectedCards.length){
              selectedCards.clear();
              _restrictStream.add(false);
            }
          });
        }
        lifeSinker.add(true);
      }
    }
  }

  bool isCardPaired(){
    if(selectedCards[0] == selectedCards[1]){
      return true;
    }
    return false;
  }

  // call it when not pairs
  Future<void> flippingBackCard(String val) async{
    _flipBack.add(val);
  }

  dispose(){
    _flipBack.close();
    _selectedCard.close();
    _restrictStream.close();
    _arcadeTimer.close();
    _lifeControl.close();
  }
}