import 'package:flutter/material.dart';

class ConstantCollections{

  static const String APPNAME = "find pairs";
  static const int APPVERSION = 1;


  static const List<Map<String,dynamic>> ARCADE_SETTING = [{
    "episode":"Episode-01",
    "totalStage": 31
  }];

  static const List<Map<String,dynamic>> MENUS = [
    {
      "name":"ARCADE",
      "version":1,
      "isAvailable": true,
      "isMaintenance": false,
      "color":Colors.red
    },
    {
      "name":"CLASSIC",
      "version":1,
      "isAvailable": true,
      "isMaintenance": false,
      "color":Colors.blue
    },
    {
      "name":"SURVIVAL",
      "version":1,
      "isAvailable": true,
      "isMaintenance": false,
      "color":Colors.purple
    },
    {
      "name":"COLLECTIONS",
      "version":1,
      "isAvailable": true,
      "isMaintenance": false,
      "color":Color(0xff6f5451)
    }
  ];



  //Preferences
  static const PREF_VOLUME = "prefVolume";
  static const PREF_ARCADE_LOG = "prefArcadeLog";
}