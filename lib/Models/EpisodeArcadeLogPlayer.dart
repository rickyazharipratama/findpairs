import 'dart:convert';

import 'package:findpairs/Models/DetailEpisodeArcadeLogPlayer.dart';

class EpisodeArcadeLogPlayer{

  String episode;
  List<DetailEpisodeArcadeLogPlayer> logs;

  EpisodeArcadeLogPlayer.initialize({
    this.episode,
    int totalStage
  }){

    logs = List();
    for(int i = 0; i < totalStage; i++){
      logs.add(DetailEpisodeArcadeLogPlayer.initialize(stage: i+1));
    }
  }


  EpisodeArcadeLogPlayer.fromStore(Map<String,dynamic> data){
    episode = data['episode'].toString();
    logs = List();
    for(String log in data['log'] as List<dynamic>){
      logs.add(DetailEpisodeArcadeLogPlayer.fromStore(json.decode(log)));
    }
  }

  Map<String,dynamic> getMap(){
    List<String> strLogs = List();
    logs.forEach((log){
      strLogs.add(json.encode(log.getMap()));
    });
    return{
      "episode":episode,
      "log":strLogs
    };
  }
}