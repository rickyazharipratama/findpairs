import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/Models/SoundModel.dart';
import 'package:flutter/widgets.dart';

class SoundManager{

 static SoundManager manager = SoundManager();

  void play({
    AudioCache player,
    String filename,
    bool isSfx = true
  }) async{
    SoundModel sound = SoundModel();
    await sound.getValueFromPreference();
    await player.play(filename,
      mode: isSfx ? PlayerMode.LOW_LATENCY : PlayerMode.MEDIA_PLAYER,
      stayAwake: false,
      volume: sound.isSilentMode ? 0 : isSfx ? sound.particleVolume : sound.musicVolume
    );
  }

  void loop({
    AudioCache player,
    String filename,
    bool isSfx = true
  }) async{
    SoundModel sound = SoundModel();
    await sound.getValueFromPreference();
    await player.loop(filename,
      mode: isSfx ? PlayerMode.LOW_LATENCY : PlayerMode.MEDIA_PLAYER,
      stayAwake: false,
      volume: sound.isSilentMode ? 0 : isSfx ? sound.particleVolume : sound.musicVolume
    );
  }

  void pauseAllSound(BuildContext context){
    FindPairsApp.of(context).presenter.particleSound.fixedPlayer.pause();
    FindPairsApp.of(context).presenter.miscSound.fixedPlayer.pause();
  }
}