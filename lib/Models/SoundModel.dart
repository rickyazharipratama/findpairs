import 'dart:convert';

import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundModel{

  double _musicVolume;
  double _particleVolume;
  bool _isSilentMode = false;

  double get musicVolume => _musicVolume;
  double get particleVolume => _particleVolume;
  bool get isSilentMode => _isSilentMode;

  set setMusicVolume(double val){
    _musicVolume = val;
  }
  set setParticleVolume(double val){
    _particleVolume  = val;
  }

  set setSilentMode(bool val){
    _isSilentMode = val;
  }

  getValueFromPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strVolume  = pref.getString(ConstantCollections.PREF_VOLUME);
    if(strVolume == null){
        setMusicVolume = 0.1;
        setParticleVolume = 0.1;
        setSilentMode = false;
        setValueToPreference();
    }else{
      Map<String,dynamic> vl = jsonDecode(strVolume);
      setMusicVolume = vl['musicVolume'];
      setParticleVolume = vl['particleVolume'];
      setSilentMode = vl['silentMode'];
    }
  }

  setValueToPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(ConstantCollections.PREF_VOLUME, jsonEncode(getMap()));
  }

  Map<String,dynamic> getMap(){
    return{
      "musicVolume": musicVolume == null ? 0.6 : musicVolume,
      "particleVolume": particleVolume == null ? 0.6 : particleVolume,
      "silentMode": isSilentMode == null ? false : isSilentMode
    };
  }

}