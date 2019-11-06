import 'dart:async';

import 'package:findpairs/PresenterViews/Pages/SurvivalPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/material.dart';

class SurvivalPagePresenter extends BasePagePresenter{

  SurvivalPageView _view;
  StreamController<GamePauseType> pauseController = StreamController();

  SurvivalPagePresenter(){
    pauseStream.listen(onPauseListen);
  }

  SurvivalPageView get view => _view;
  set setView(SurvivalPageView vw){
    _view = vw;
  }

  StreamSink<GamePauseType> get pauseSink => pauseController.sink;
  Stream<GamePauseType> get pauseStream => pauseController.stream;

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
  }
}