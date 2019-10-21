import 'dart:convert';

import 'package:findpairs/Models/EpisodeArcadeLogPlayer.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArcadeLogPlayer{

  List<EpisodeArcadeLogPlayer> episodes;


  ArcadeLogPlayer.initialize(){
    episodes = List();
    List<dynamic> data = ConstantCollections.ARCADE_SETTING;
    data.forEach((dt){
      episodes.add(EpisodeArcadeLogPlayer.initialize(
        episode: dt['episode'],
        totalStage: dt['totalStage']
      ));
    });
  }

  ArcadeLogPlayer();


  Future<void> retrieveData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> str = pref.getStringList(ConstantCollections.PREF_ARCADE_LOG);
    if(str != null){
      episodes = List();
      str.forEach((val){
        episodes.add(EpisodeArcadeLogPlayer.fromStore(json.decode(val)));
      });
    }
  }

  List<String> _getEncodeValue(){
    List<String> str = List();
    episodes.forEach((ep){
      str.add(json.encode(ep.getMap()));
    });
    return str;
  }

  

  void savingToPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(ConstantCollections.PREF_ARCADE_LOG, _getEncodeValue());
  }
}