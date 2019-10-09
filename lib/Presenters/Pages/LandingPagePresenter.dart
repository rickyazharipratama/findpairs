
import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/PresenterViews/Pages/LandingPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:flutter/rendering.dart';

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

  void disposingStream(){
    _streamController.close();
  }

  @override
  void initiateData() {
    super.initiateData();
    FindPairsApp.of(view.currentContext()).presenter.bgSound.open(
      AssetsAudio(
        asset: "landing-page.ogg",
        folder: "assets/sounds/"
      )
    );
    FindPairsApp.of(view.currentContext()).presenter.bgSound.finished.listen((isFinished){
      debugPrint("music finish listen called");
       if(isFinished){
         debugPrint("music isFinished");
         stopBackgroundMusic();
         Timer(const Duration(milliseconds: 1500),(){
           playBackgroundMusic();
         });
       }
    });
    playBackgroundMusic();
  }

  @override
  playBackgroundMusic(){
    super.playBackgroundMusic();
    FindPairsApp.of(view.currentContext()).presenter.bgSound.play();
  }

  @override
  pauseBackgroundMusic() {
    super.pauseBackgroundMusic();
    FindPairsApp.of(view.currentContext()).presenter.bgSound.pause();
  }
  
  @override
  stopBackgroundMusic() {
    super.stopBackgroundMusic();
    FindPairsApp.of(view.currentContext()).presenter.bgSound.stop();
  }
}