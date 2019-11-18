import 'dart:async';

import 'package:findpairs/Models/SurvivalScore.dart';
import 'package:findpairs/PresenterViews/Pages/SurvivalPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurvivalPagePresenter extends BasePagePresenter{

  SurvivalPageView _view;
  StreamController<GamePauseType> pauseController = StreamController.broadcast();
  StreamController<bool> _dragTargetRestrictedController = StreamController.broadcast();
  StreamController<int> _clearDragtargetController = StreamController.broadcast();
  StreamController<int> _finderCardValueController = StreamController();
  StreamController<bool> _fasterRaceController = StreamController.broadcast();
  StreamController<Map<String,int>> _dragTargetController = StreamController();
  StreamController<bool> _isCardCorrectController = StreamController.broadcast();
  StreamController<SurvivalScore> _reportScoreController = StreamController();
  StreamController<bool> _restartGameController = StreamController.broadcast();

  SurvivalScore score;
  GamePauseType pauseType;

  SurvivalPagePresenter(){
    reportScoreStream.listen(rekapScore);
    pauseStream.listen(onPauseType);
  }


  onPauseType(GamePauseType type){
    pauseType = type;
  }

  rekapScore(SurvivalScore sc) async{
    score = SurvivalScore();
    await score.getFromStore();
    print("last score : "+score.score.toString());
    print("new Score : "+sc.score.toString());
    if(score.score < sc.score){
      //new best record
      sc.setFromStore();
      ArcadeAction act = await view.showCompleteDialog(
        episode: "Episode-01",
        message: "New Record",
        star: 3,
      );
      if(act == ArcadeAction.nextStage){
        restartGameSink.add(true);
      }else if(act == ArcadeAction.retryGame){
        Navigator.of(view.currentContext()).pop();
      }
    }else{
      //just game over
      ArcadeAction act = await view.showNegativeDialog(
        episode: "Episode-01",
        title: "Game Over"
      );
      if(act == ArcadeAction.retryGame){
        restartGameSink.add(true);
      }else{
        Navigator.of(view.currentContext()).pop();
      }
    }
  }

  SurvivalPageView get view => _view;
  set setView(SurvivalPageView vw){
    _view = vw;
  }

  StreamSink<GamePauseType> get pauseSink => pauseController.sink;
  Stream<GamePauseType> get pauseStream => pauseController.stream;

  StreamSink<bool> get dragTargetRestrictedSink => _dragTargetRestrictedController.sink;
  Stream<bool> get dragTargetRestrictedStream => _dragTargetRestrictedController.stream;

  StreamSink<int> get clearDragTargetSink => _clearDragtargetController.sink;
  Stream<int> get clearDragTargetStream => _clearDragtargetController.stream;

  StreamSink<int> get finderCardValueSink => _finderCardValueController.sink;
  Stream<int> get finderCardValueStream => _finderCardValueController.stream;

  StreamSink<bool> get fasterRaceSink => _fasterRaceController.sink;
  Stream<bool> get fasterRaceStream => _fasterRaceController.stream;

  StreamSink<Map<String,int>> get dragTargetSink => _dragTargetController.sink;
  Stream<Map<String,int>> get dragTargetStream => _dragTargetController.stream;

  StreamSink<bool> get isCardCorrectSink => _isCardCorrectController.sink;
  Stream<bool> get isCardCorrectStream => _isCardCorrectController.stream;

  StreamSink<SurvivalScore> get reportScoreSink => _reportScoreController.sink;
  Stream<SurvivalScore> get reportScoreStream => _reportScoreController.stream;
  
  StreamSink<bool> get restartGameSink => _restartGameController.sink;
  Stream<bool> get restartGameStream => _restartGameController.stream;



  @override
  void initiateData() async{
    super.initiateData();
    showTutorial();
  }


  showTutorial() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isAlreadyPlayTutorial = pref.getBool(ConstantCollections.PREF_MATCHER_TUTORIAL);
    if(isAlreadyPlayTutorial == null || !isAlreadyPlayTutorial){
      Future.delayed(
        const Duration(milliseconds: 4000),
        (){
          if(view.isMounted()){
            if(pauseType == GamePauseType.onGameresume){
              pauseSink.add(GamePauseType.onGamePause);
              view.showTutorial(
                onFinish: finishTutorial
              );
            }
          }
        }
      );
    }
  }

  finishTutorial() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(ConstantCollections.PREF_MATCHER_TUTORIAL, true);
    if(pauseType == GamePauseType.onGamePause){
      if(view.isMounted()){
        pauseSink.add(GamePauseType.onGameresume);
      }
    }
  }

  void dispose(){
    pauseController.close();
    _dragTargetRestrictedController.close();
    _clearDragtargetController.close();
    _finderCardValueController.close();
    _fasterRaceController.close();
    _dragTargetController.close();
    _isCardCorrectController.close();
    _reportScoreController.close();
    _restartGameController.close();
  }
}