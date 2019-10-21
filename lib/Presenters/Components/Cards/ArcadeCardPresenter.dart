import 'dart:async';
import 'dart:math';

import 'package:findpairs/Models/ArcadeCardValue.dart';
import 'package:findpairs/Models/ArcadeLogPlayer.dart';
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
  StreamController<int> _currentTime = StreamController();
  StreamController<int> _pairedController = StreamController.broadcast();

  StreamSink<int> stageSink;
  StreamSink<String> episodeSink;

  List<ArcadeCardValue> _selectedCards = List();
  // default score will reduce
  int _stages;
  String _episode;
  ArcadeSetting _setting;
  List<ArcadeCardValue> _cardsValue;
  int _mustPaired= 0;
  int _currentLife;
  int _currentCountDown = 0;



  CardView get view => _view;
  set setView(CardView vw){
    _view = vw;
  }

  set setMustPaired(int val){
    _mustPaired = val;
  }
  int get mustPaired => _mustPaired;

  List<ArcadeCardValue> get selectedCards => _selectedCards;

  Stream<int> get flipBack => _flipBack.stream;
  Stream<bool> get restrictFlip => _restrictStream.stream;
  StreamSink<ArcadeCardValue> get selectedCardSinker => _selectedCard.sink;

  ArcadeSetting get setting => _setting;

  set setStages(int val){
    _stages = val;
  }
  int get stages => _stages;

  String get episode => _episode;

  List<ArcadeCardValue> get cardsValue => _cardsValue;

  StreamSink<ArcadeTimer> get arcadeTimerSinker => _arcadeTimer.sink;
  Stream<ArcadeTimer> get arcadeTimerStream => _arcadeTimer.stream;

  StreamSink<bool> get lifeSinker => _lifeControl.sink;
  Stream<bool> get lifeStream => _lifeControl.stream;

  StreamSink<int> get currentCD => _currentTime.sink;
  Stream<int> get cdStream => _currentTime.stream;

  StreamSink<int> get pairedSink =>_pairedController.sink;
  Stream<int> get pairedStream => _pairedController.stream;

  int get currentLife => _currentLife;
  set setCurrentLife(int val){
    _currentLife = val;
  }

  ArcadeCardPresenter(int stg, String ep, StreamSink<int> stgSink, StreamSink<String>epSink){
    _stages = stg;
    _episode = ep;
    stageSink = stgSink;
    episodeSink = epSink;
  }

  @override
  void initiateData() async{
    super.initiateData();
    _selectedCard.stream.listen(addSelectedCard);
    ArcadeUtils utils = ArcadeUtils(episode);
    _setting = await utils.getArcadeSetting(stages.toString());
    setCurrentLife = _setting.life;
    setMustPaired = _setting.uniqueCard;
    _cardsValue = List();
    for(int i = 0; i < 2; i++){
      for(int j= 0;j < _setting.uniqueCard;j++){
        _cardsValue.add(ArcadeCardValue((_setting.uniqueCard * i) + j,j.toString()));
      }
    }
    arcadeTimerStream.listen(timeIsUp);
    cdStream.listen(getCurrentCountdown);
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
    if(selectedCards.length == 2){
      _restrictStream.add(true);
      if(isCardPaired()){
        //should animate becasue  card is paired
        selectedCards.forEach((selected){
          _cardsValue[_cardsValue.indexOf(selected)].setAlreadyPaired = true;
          pairedSink.add(selected.key);
        });
        selectedCards.clear();
        Timer(const Duration(milliseconds: 500),(){
          _restrictStream.add(false);
          allCardIsPaired();
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
        setCurrentLife = currentLife - 1;
        lifeSinker.add(true);
        if(currentLife == 0){
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

  List<ArcadeCardValue> gethint(){

    List<ArcadeCardValue> notPairedCards = cardsValue.where((card)=> !card.isAlreadyPaired).toList();
    if(notPairedCards.length > 1){
      Random rand = Random();
      List<ArcadeCardValue> hintCards = List();
      ArcadeCardValue firstCard = notPairedCards[rand.nextInt(notPairedCards.length - 1)];
      hintCards.add(firstCard);
      notPairedCards.forEach((card){
        if(card.value == firstCard.value && card.key != firstCard.key){
          hintCards.add(card);
        }
      });
      return hintCards;
    }
    return List();
  }

  void allCardIsPaired(){
    if(mustPaired == 0){
      print("all is paired");
      arcadeTimerSinker.add(ArcadeTimer.onGameFinished);
    }
  }

  void completingGame() async{
    double dividerLife = 100 / _setting.life;
    double dividerTime = 100 / _setting.time;
    double currentScoreByLife = currentLife * dividerLife;
    double currentScoreByTime = _currentCountDown * dividerTime;
    double totalScore = currentScoreByLife + currentScoreByTime;
    print("current cd :"+_currentCountDown.toString());
    print("currentScore by life : "+currentScoreByLife.toString());
    print("current score by time : "+currentScoreByTime.toString());
    print("total score : "+ totalScore.toString());
    int star = getStarScore(totalScore);
    ArcadeAction act = await view.showCompleteDialog(
      star: star
    );
    if(act == ArcadeAction.retryGame){
      reInitiateGame();
    }else if(act == ArcadeAction.nextStage){
      ArcadeLogPlayer log = ArcadeLogPlayer();
      await log.retrieveData();
      log.episodes[log.episodes.indexWhere((ep)=> ep.episode == this.episode)].logs[this.stages - 1].setScore = totalScore;
      log.episodes[log.episodes.indexWhere((ep)=> ep.episode == this.episode)].logs[this.stages - 1].setStar = star;
     if(this.stages < log.episodes[log.episodes.indexWhere((ep)=> ep.episode == this.episode)].logs.length){
       log.episodes[log.episodes.indexWhere((ep)=> ep.episode == this.episode)].logs[this.stages].setLocked = false;
       this.setStages = log.episodes[log.episodes.indexWhere((ep)=> ep.episode == this.episode)].logs[this.stages].stage;
       print("stages "+this.stages.toString());
       stageSink.add(this.stages);
       reInitiateGame();
     }else{
       //it should change episode because it's already reach the max stages
     }
    }
  }

  int getStarScore(double totalScore){
    if(totalScore > 130){
      return 3;
    }else if(totalScore > 71 && totalScore < 130){
      return 2;
    }else{
      return 1;
    }
  }

  bool isCardPaired(){
    if(selectedCards[0].value == selectedCards[1].value){
      setMustPaired = mustPaired - 1;
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

  void getCurrentCountdown(int cd){
    _currentCountDown = cd;
    completingGame();
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
    setCurrentLife = _setting.life;
    setMustPaired = _setting.uniqueCard;
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
    _currentTime.close();
    _pairedController.close();
  }
}