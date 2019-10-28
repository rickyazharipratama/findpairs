import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:findpairs/Models/SoundModel.dart';
import 'package:findpairs/PresenterViews/FindPairsAppPresenterView.dart';
import 'package:findpairs/Presenters/BasePresenter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class FindPairsAppPresenter extends BasePresenter{

  FindPairsAppPresenterView _view;
  AudioCache musicSound;
  AudioCache sfxSound;

  AudioPlayer _musicPlayer;
  AudioPlayer _sfxPlayer;

  SoundModel _soundVolume;

  FindPairsAppPresenterView get view => _view;
  set setView(FindPairsAppPresenterView vw){
    _view = vw;
  }

  SoundModel get soundVolume => _soundVolume;
  set setSoundVolume(SoundModel model){
    _soundVolume = model;
  }

  FindPairsAppPresenter(){
    setSoundVolume = SoundModel();
    
    _musicPlayer = AudioPlayer(
      mode: PlayerMode.MEDIA_PLAYER
    )..setVolume(0.05);

    _sfxPlayer = AudioPlayer(
      mode: PlayerMode.LOW_LATENCY
    )..setVolume(0.08);

    musicSound = AudioCache(
      prefix: "sounds/",
      fixedPlayer: _musicPlayer
    );

    sfxSound = AudioCache(
      prefix: "sounds/sfx/",
      fixedPlayer: _sfxPlayer
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

    debugPrint("keLoad sampai disini");
    // await musicSound.loadAll([
    //   "landing-page.ogg"
    // ]);
    await sfxSound.loadAll([
      "button_tap.mp3",
      "swiping_menu.mp3",
      "lost_life.mp3",
      "card_flip.mp3",
      "cheers.mp3",
      "awww.mp3"
    ]);

    view.setViewState = 0;
    view.notifyState();
  }

  void clearBackgroundSound(){
    //must be clear cache
  }

  void clearParticleSound(){
    //must be clear cache
  }
}