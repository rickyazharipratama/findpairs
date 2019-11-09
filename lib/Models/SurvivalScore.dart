import 'dart:convert';

import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurvivalScore{

  int _score = 0;
  double _v = 70;

  int get score => _score;
  set increaseScore(int score){
    _score+=3;
  }
  double get v => _v;

  int getTimebyDistance(double distance){
    return (distance / v).ceil();
  }

  getFromStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String str = pref.getString(ConstantCollections.PREF_SURVIVAL_SCORE);
    if(str != null){
      Map<String,dynamic> data = json.decode(str);
      _score = data['score'];
      _v = data['v'];
    }
  }

  setFromStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String,dynamic> data = {
      "score" : _score,
      "v" : _v
    };
    pref.setString(ConstantCollections.PREF_SURVIVAL_SCORE, json.encode(data));
  }
}