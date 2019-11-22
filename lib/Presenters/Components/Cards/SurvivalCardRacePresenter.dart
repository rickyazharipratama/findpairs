import 'dart:async';
import 'dart:math';

import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/Models/SurvivalScore.dart';
import 'package:findpairs/PresenterViews/Components/Cards/SurvivalCardRaceView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Utils/SoundManager.dart';
import 'package:flutter/widgets.dart';

class SurvivalCardRacePresenter extends BaseComponentPresenter{

  SurvivalCardRaceView _view;
  final double cardHeight;
  final StreamSink<bool> restrictDragTargetSink;
  final StreamSink<int> clearDragTargetSink;
  final Stream<int> finderValueStream;
  final Stream<bool> fasterRaceStream;
  final Stream<Map<String,int>> dragTargetStream;
  final StreamSink<bool> isCardCorrectSink;
  final Stream<GamePauseType> pauseStream;
  SurvivalScore _score;
  bool _isRestrictedActivate = false;
  bool _isCorrectAlreadyBroadcast = false;
  List<int> cardRaces;
  Map<String,int> _dragTarget;
  bool _isGamePaused = false;

  SurvivalCardRacePresenter({this.cardHeight, this.restrictDragTargetSink, this.clearDragTargetSink, this.finderValueStream, this.fasterRaceStream, this.dragTargetStream, this.isCardCorrectSink, this.pauseStream}){
    _score = SurvivalScore();
    finderValueStream.listen(listenFinderValue);
    fasterRaceStream.listen(fasteningAnimation);
    dragTargetStream.listen(listenDragTarget);
    pauseStream.listen(listenGamePause);
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
    _isCorrectAlreadyBroadcast = false;
  }

  

  listenGamePause(GamePauseType type) async{
    if(type == GamePauseType.onGamePause){
      view.animationController.stop();
      _isGamePaused = true;
    }else if(type == GamePauseType.onGameresume){
      if(await view.prepareToPlay()){
        view.animationController.forward();
        _isGamePaused = false;
      }
    }else if(type == GamePauseType.onGameExit){
      Navigator.of(view.currentContext()).pop();
    }
  }

  listenDragTarget(Map<String,int> target){
    _dragTarget = target;
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
    _isCorrectAlreadyBroadcast = false;
    cardRaces.shuffle(); 
    reinitiateAnimation();
  }

  void animationListener(){
    double max = view.firstCardAnimation.value;
    if(max < view.secondCardAnimation.value){
      max = view.secondCardAnimation.value;
    }
    if(max < view.thirdCardAnimation.value){
      max = view.thirdCardAnimation.value;
    }
    if(max >= view.compareLine){
      CommonUtil.instance.showLog(log:"comparing area");
      if(!_isCorrectAlreadyBroadcast){
        CommonUtil.instance.showLog(log:"comparing prepare broadcast");
        _isCorrectAlreadyBroadcast = true;
        if(_dragTarget == null){
          //should end
          view.animationController.stop();
          SoundManager.manager.play(
            player: FindPairsApp.of(view.currentContext()).presenter.particleSound,
            filename: "awww.mp3"
          );
          isCardCorrectSink.add(false);
        }else{
          if(cardRaces[_dragTarget['position']] == _dragTarget['value']){
            // score increase
            SoundManager.manager.play(
              player: FindPairsApp.of(view.currentContext()).presenter.particleSound,
              filename: "cheers.mp3"
            );
            isCardCorrectSink.add(true);
          }else{
            view.animationController.stop();
            // should end
            SoundManager.manager.play(
              player: FindPairsApp.of(view.currentContext()).presenter.particleSound,
              filename: "awww.mp3"
            );
            isCardCorrectSink.add(false);
          }
        }
      }
    }else if(max >= view.restrictMoveLine){
      CommonUtil.instance.showLog(log:"restricting area");
      if(!isRestrictedActivate){
        CommonUtil.instance.showLog(log:"restricted card");
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
      _dragTarget = null;
      _isCorrectAlreadyBroadcast = false;
    }
  }

  void reinitiateAnimation(){
    if(!_isGamePaused){
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
  }

  void fasteningAnimation(bool isFastening){
    if(!_isGamePaused){
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
      double distance = view.finishLine - minDistance;

      if(isFastening){
        view.setAnimationController = Duration(milliseconds: score.getTimebyDistance(distance) * (1000/5).ceil());
      }else{
        view.setAnimationController = Duration(milliseconds: score.getTimebyDistance(distance) * 1000);
      }
      view.animationController
      ..addListener(animationListener)
      ..addStatusListener(listenAnimationStatus);
      view.setFirstCardAnimation = view.firstCardAnimation.value;
      view.setSecondCardAnimation = view.secondCardAnimation.value;
      view.setThirdCardAnimation =view.thirdCardAnimation.value;
      view.animationController.forward();
    }
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

  void dispose(){
    view.animationController.dispose();
  }
}