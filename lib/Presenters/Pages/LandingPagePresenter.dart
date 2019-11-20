import 'dart:async';

import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/PresenterViews/Pages/LandingPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';

class LandingPagePresenter extends BasePagePresenter{

  LandingPageView _view;
  StreamController<Map<String,dynamic>> _streamController = StreamController();
  StreamController<bool> _notifyReactiveController = StreamController.broadcast();

  StreamController get streamController => _streamController;

  Stream<Map<String,dynamic>> get stream => _streamController.stream;

  Stream<bool> get notifyReactiveStream => _notifyReactiveController.stream;
  StreamSink<bool> get notifyReactiveSink => _notifyReactiveController.sink;

  LandingPageView get view => _view;
  set setView(LandingPageView vw){
    _view = vw;
  }

  LandingPagePresenter();

  void dispose(){
    disposeBackgroundMusic();
    _streamController.close();
    _notifyReactiveController.close();
  }

  @override
  void initiateData()async{
    super.initiateData();
  }

  @override
  playBackgroundMusic() {
    super.playBackgroundMusic();
  }

  @override
  pauseBackgroundMusic() {
    super.pauseBackgroundMusic();
  }
  
  @override
  stopBackgroundMusic() {
    super.stopBackgroundMusic();
  }

  @override
  void disposeBackgroundMusic() {
    super.disposeBackgroundMusic();
    FindPairsApp.of(view.currentContext()).presenter.clearSound();
  }
}