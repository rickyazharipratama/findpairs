import 'dart:convert';

import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundModel{

  double _musicVolume;
  double _particleVolume;

  double get musicVolume => _musicVolume;
  double get particleVolume => _particleVolume;

  set setMusicVolume(double val){
    _musicVolume = val;
  }
  set setParticleVolume(double val){
    _particleVolume  = val;
  }

  getValueFromPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strVolume  = pref.getString(ConstantCollections.PREF_VOLUME);
    if(strVolume == null){
        setMusicVolume = .6;
        setParticleVolume = .6;
        setValueToPreference();
    }else{
      Map<String,dynamic> vl = jsonDecode(strVolume);
      setMusicVolume = vl['musicVolume'];
      setParticleVolume = vl['particleVolume'];
    }
  }

  setValueToPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(ConstantCollections.PREF_VOLUME, jsonEncode(getMap()));
  }

  Map<String,dynamic> getMap(){
    return{
      "musicVolume": musicVolume == null ? 0.6 : musicVolume,
      "particleVolume": particleVolume == null ? 0.6 : particleVolume
    };
  }

}