import 'package:flutter/material.dart';

class FindPairsTheme{

  static FindPairsTheme instance = FindPairsTheme();

  ThemeData lightFindPairsTheme = ThemeData(
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      subtitle: TextStyle(
        fontFamily: "chunky",
        color: Color(0xff777777),
        fontSize: 40
      )
    )
  );

}