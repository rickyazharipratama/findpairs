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
      "name":"Arcade",
      "icon":"assets/images/arcade-menu.png",
      "version":1,
      "isAvailable": true,
      "isMaintenance": false,
      "color":Color(0xffbc262c),
      "gradientColor":Color(0xffd22a30),
      "iconColor":Color(0xff77161a)
    },
    {
      "name":"Classic",
      "icon":"assets/images/classic.png",
      "version":1,
      "isAvailable": true,
      "isMaintenance": false,
      "color":Color(0xffcfad56),
      "gradientColor":Color(0xffe6c163),
      "iconColor":Color(0xffac893b)
    },
    {
      "name":"Survival",
      "icon":"assets/images/survival.png",
      "version":1,
      "isAvailable": true,
      "isMaintenance": false,
      "color":Color(0xff67ad2c),
      "gradientColor":Color(0xff7ac838),
      "iconColor":Color(0xff037231)
    },
    {
      "name":"Collection",
      "icon":"assets/images/collections.png",
      "version":1,
      "isAvailable": true,
      "isMaintenance": false,
      "color":Color(0xfff77d00),
      "gradientColor":Color(0xfff99229),
      "iconColor":Color(0xffca5d00)
    }
  ];



  //Preferences
  static const PREF_VOLUME = "prefVolume";
  static const PREF_ARCADE_LOG = "prefArcadeLog";
}