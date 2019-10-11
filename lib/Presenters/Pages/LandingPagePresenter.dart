
import 'dart:async';

import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/PresenterViews/Pages/LandingPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';

class LandingPagePresenter extends BasePagePresenter{

  LandingPageView _view;
  StreamController<Map<String,dynamic>> _streamController;

  StreamController get streamController => _streamController;

  Stream<Map<String,dynamic>> get stream => _streamController.stream;

  LandingPageView get view => _view;
  set setView(LandingPageView vw){
    _view = vw;
  }

  LandingPagePresenter(){
    _streamController = StreamController();
  }

  void dispose(){
    disposeBackgroundMusic();
    _streamController.close();
  }

  @override
  void initiateData()async{
    super.initiateData();
    playBackgroundMusic();
  }

  @override
  playBackgroundMusic() {
    super.playBackgroundMusic();
    FindPairsApp.of(view.currentContext()).presenter.musicSound.loop("landing-page.ogg");
  }

  @override
  pauseBackgroundMusic() {
    super.pauseBackgroundMusic();
    FindPairsApp.of(view.currentContext()).presenter.musicSound.fixedPlayer.pause();
  }
  
  @override
  stopBackgroundMusic() {
    super.stopBackgroundMusic();
    FindPairsApp.of(view.currentContext()).presenter.musicSound.fixedPlayer.stop();
  }

  @override
  void disposeBackgroundMusic() {
    super.disposeBackgroundMusic();
    FindPairsApp.of(view.currentContext()).presenter.musicSound.clear("landing-page.ogg");
  }
}