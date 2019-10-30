import 'dart:convert';

import 'package:findpairs/Models/ArcadeSetting.dart';
import 'package:flutter/services.dart';

class ArcadeUtils{
  final String episode;
  ArcadeUtils(this.episode);

  Future<ArcadeSetting> getArcadeSetting(String stages) async{
    return ArcadeSetting(await getSettingArcade(stages));
  }

  Future<Map<String,dynamic>> getSettingArcade(String stages) async{
    String jsonAsset = await rootBundle.loadString("assets/json/arcades/"+episode+".json");
    return (jsonDecode(jsonAsset)[stages]);
  } 
}