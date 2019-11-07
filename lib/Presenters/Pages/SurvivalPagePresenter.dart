import 'dart:async';

import 'package:findpairs/PresenterViews/Pages/SurvivalPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/material.dart';

class SurvivalPagePresenter extends BasePagePresenter{

  SurvivalPageView _view;
  StreamController<GamePauseType> pauseController = StreamController();
  StreamController<bool> _dragTargetRestrictedController = StreamController.broadcast();
  StreamController<int> _clearDragtargetController = StreamController.broadcast();
  StreamController<int> _finderCardValueController = StreamController();
  StreamController<bool> _fasterRaceController = StreamController.broadcast();

  SurvivalPagePresenter(){
    pauseStream.listen(onPauseListen);
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

  @override
  void initiateData() {
    super.initiateData();
  }

  void onPauseListen(GamePauseType type){
    if(type == GamePauseType.onGameExit){
      Navigator.of(view.currentContext()).pop();
    }
  }

  void dispose(){
    pauseController.close();
    _dragTargetRestrictedController.close();
    _clearDragtargetController.close();
    _finderCardValueController.close();
    _fasterRaceController.close();
  }
}