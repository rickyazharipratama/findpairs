import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:findpairs/PresenterViews/FindPairsAppPresenterView.dart';
import 'package:findpairs/Presenters/BasePresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class FindPairsAppPresenter extends BasePresenter{

  FindPairsAppPresenterView _view;
  AudioCache miscSound;
  AudioCache particleSound;
  AudioPlayer _miscAudioPlayer;
  AudioPlayer _particleAudioPlayer;

  FindPairsAppPresenterView get view => _view;
  set setView(FindPairsAppPresenterView vw){
    _view = vw;
  }

  FindPairsAppPresenter(){
  
    _miscAudioPlayer = AudioPlayer(
      mode: PlayerMode.MEDIA_PLAYER
    );
    _particleAudioPlayer = AudioPlayer(
      mode: PlayerMode.LOW_LATENCY
    );

    miscSound = AudioCache(
      prefix: "sounds/sfx/",
      fixedPlayer: _miscAudioPlayer
    );

    particleSound = AudioCache(
      prefix: "sounds/sfx/",
      fixedPlayer: _particleAudioPlayer
    );
  }

  @override
  void initiateData() async{
    super.initiateData();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Color(0x00000000),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff252525),
      systemNavigationBarIconBrightness: Brightness.light
    ));
    CommonUtil.instance.showLog(log:"keLoad sampai disini");
    view.setViewState = 0;
    view.notifyState();
  }

  Future<void> loadingSound() async{
    await miscSound.loadAll([
      "tick_tock.mp3",
    ]);
    await particleSound.loadAll([
      "button_tap.mp3",
      "lost_life.mp3",
      "card_flip.mp3",
      "cheers.mp3",
      "awww.mp3",
      "ready_arcade.mp3",
      "start_arcade.mp3"
    ]);
  }

  Future<void> clearSound() async{
    miscSound.clearCache();
    particleSound.clearCache();
  }

  void clearBackgroundSound(){
    //must be clear cache
  }

  void clearParticleSound(){
    //must be clear cache
  }
}