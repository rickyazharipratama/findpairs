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


  static const Map<String, List<String>> cards ={
    "Episode-01" : [
      "assets/images/galaxies/space-ship-3.png",
      "assets/images/galaxies/milky-way.png",
      "assets/images/galaxies/space-station.png",
      "assets/images/galaxies/venus.png",
      "assets/images/galaxies/saturn.png",
      "assets/images/galaxies/artificial-gravity-modulo.png",
      "assets/images/galaxies/europa.png",
      "assets/images/galaxies/comet-1.png",
      "assets/images/galaxies/mars.png",
      "assets/images/galaxies/uranus.png",
      "assets/images/galaxies/satellite.png",
      "assets/images/galaxies/planet-earth-4.png",
      "assets/images/galaxies/planet-earth-1.png",
      "assets/images/galaxies/mercury.png",
      "assets/images/galaxies/jupiter.png",
      "assets/images/galaxies/space-ship-7.png",
      "assets/images/galaxies/space-ship-6.png",
      "assets/images/galaxies/space-ship-2.png",
      "assets/images/galaxies/observatory.png",
      "assets/images/galaxies/meteorite.png",
      "assets/images/galaxies/sputnik.png",
      "assets/images/galaxies/spaceship-1.png",
      "assets/images/galaxies/space-station-1.png",
      "assets/images/galaxies/space-ship.png",
      "assets/images/galaxies/moon.png",
      "assets/images/galaxies/ursa-major.png",
      "assets/images/galaxies/ufo.png",
      "assets/images/galaxies/sun.png",
      "assets/images/galaxies/stargate.png",
      "assets/images/galaxies/neptune.png",
      "assets/images/galaxies/comet.png",
      "assets/images/galaxies/satellite-2.png"
    ]
  };

  static const Map<String,dynamic> backCards = {
    "Episode-01":{
      "icon":"assets/images/galaxies/solar-system.png",
      "color": Colors.red,
      "gradientColor": Colors.red
    }
  };

}