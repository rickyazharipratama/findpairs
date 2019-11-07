import 'dart:async';
import 'dart:math';

import 'package:findpairs/Models/SurvivalScore.dart';
import 'package:findpairs/PresenterViews/Components/Cards/SurvivalCardRaceView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:flutter/widgets.dart';

class SurvivalCardRacePresenter extends BaseComponentPresenter{

  SurvivalCardRaceView _view;
  final double cardHeight;
  final StreamSink<bool> restrictDragTargetSink;
  final StreamSink<int> clearDragTargetSink;
  final Stream<int> finderValueStream;
  final Stream<bool> fasterRaceStream;
  SurvivalScore _score;
  bool _isRestrictedActivate = false;
  List<int> cardRaces;

  SurvivalCardRacePresenter({this.cardHeight, this.restrictDragTargetSink, this.clearDragTargetSink, this.finderValueStream, this.fasterRaceStream}){
    _score = SurvivalScore();
    finderValueStream.listen(listenFinderValue);
    fasterRaceStream.listen(fasteningAnimation);
  }

  set setView(SurvivalCardRaceView vw){
    _view = vw;
  }
  SurvivalCardRaceView get view => _view;

  set setScore(SurvivalScore scr){
    _score = scr;
  }
  SurvivalScore get score => _score;

  bool get isRestrictedActivate => _isRestrictedActivate;
  set setRestrictedActivate(bool val){
    _isRestrictedActivate = val;
  }

  @override
  void initiateData() async{
    super.initiateData();
    await _score.getFromStore();
  }


  void listenFinderValue(int val){
    if(cardRaces == null){
      cardRaces = List();
    }else{
      cardRaces.clear();
    }

    cardRaces.add(val);
    for(int i = 0; i < 2; i++){
      cardRaces.add(CommonUtil.instance.getUniqueRandom(
        max: 32,
        reference: cardRaces
      ));
    }
    cardRaces.shuffle();
    reinitiateAnimation();
  }

  void animationListener(){
    if(view.firstCardAnimation.value >= view.restrictMoveLine
    || view.secondCardAnimation.value >= view.restrictMoveLine
    || view.thirdCardAnimation.value >= view.restrictMoveLine){
      if(!isRestrictedActivate){
        print("restricted card");
        setRestrictedActivate = true;
        restrictDragTargetSink.add(isRestrictedActivate);
      }
    }
    view.notifyState();
  }

  void listenAnimationStatus(AnimationStatus status){
    if(status == AnimationStatus.completed){
      setRestrictedActivate = false;
      restrictDragTargetSink.add(isRestrictedActivate);
      clearDragTargetSink.add(-1);
    }
  }

  void reinitiateAnimation(){
    if(view.animationController != null){
      view.animationController.dispose();
    }
    view.setAnimationController = Duration(milliseconds: score.getTimebyDistance(view.finishLine) * 1000);
    view.animationController
    ..addListener(animationListener)
    ..addStatusListener(listenAnimationStatus);
    view.setFirstCardAnimation = getBeginLine();
    view.setSecondCardAnimation = getBeginLine();
    view.setThirdCardAnimation = getBeginLine();
    view.animationController.forward();
  }

  void fasteningAnimation(bool isFastening){
    double minDistance = view.firstCardAnimation.value;
    if(minDistance > view.secondCardAnimation.value){
      minDistance = view.secondCardAnimation.value;
    }
    if(minDistance > view.thirdCardAnimation.value){
      minDistance = view.thirdCardAnimation.value;
    }
    if(view.animationController != null){
      view.animationController.dispose();
    }
    if(isFastening){
      view.setAnimationController = Duration(milliseconds: score.getTimebyDistance(minDistance) * 200);
    }else{
      view.setAnimationController = Duration(milliseconds: score.getTimebyDistance(minDistance) * 1000);
    }
    view.animationController
    ..addListener(animationListener)
    ..addStatusListener(listenAnimationStatus);
    view.setFirstCardAnimation = view.firstCardAnimation.value;
    view.setSecondCardAnimation = view.secondCardAnimation.value;
    view.setThirdCardAnimation =view.thirdCardAnimation.value;
    view.animationController.forward();
  }

  double getBeginLine(){
    Random random = Random();
    int nxt = random.nextInt(3);
    if(nxt == 1){
      return -cardHeight - (cardHeight * 3 / 4);
    }else if(nxt == 2){
      return -cardHeight - (cardHeight / 2);
    }
    return -cardHeight;
  }
}