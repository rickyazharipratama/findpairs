import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:findpairs/Models/SoundModel.dart';
import 'package:findpairs/PresenterViews/FindPairsAppPresenterView.dart';
import 'package:findpairs/Presenters/BasePresenter.dart';
import 'package:flutter/rendering.dart';

class FindPairsAppPresenter extends BasePresenter{

  FindPairsAppPresenterView _view;
  AssetsAudioPlayer bgSound;
  AssetsAudioPlayer particleSound;
  
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
    bgSound = AssetsAudioPlayer();
    particleSound = AssetsAudioPlayer();
  }

  @override
  void initiateData() async{
    super.initiateData();
    await soundVolume.getValueFromPreference();

    debugPrint("keLoad sampai disini");
  }

  void clearBackgroundSound(){
    //must be clear cache
  }

  void clearParticleSound(){
    //must be clear cache
  }

}