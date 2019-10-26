import 'package:flutter/material.dart';

class FindPairsTheme{

  static FindPairsTheme instance = FindPairsTheme();

  ThemeData lightFindPairsTheme = ThemeData(
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      subtitle: TextStyle(
        fontFamily: "avocado",
        color: Color(0xff777777),
        fontSize: 40
      ),
      //stages title
      display1: TextStyle(
        fontFamily: "avocado",
        color: Color(0xff777777),
        fontSize: 30
      ),
      //countdown arcade
      display2: TextStyle(
        fontFamily: "avocado",
        color: Color(0xff777777),
        fontSize: 50
      ),

      //lifeExtendedFont
      display3: TextStyle(
        fontFamily: "avocado",
        color: Color(0xff777777),
        fontSize: 16
      ),
      // button
      display4: TextStyle(
        fontFamily: "avocado",
        color: Color(0xff777777),
        fontSize: 20
      ),
    )
  );

}