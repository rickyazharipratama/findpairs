import 'package:flutter/material.dart';

class SurvivalPageView{

  Size get cardSize{
    double width = (MediaQuery.of(currentContext()).size.width - 60) / 4;
    double stacked = (MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom)) * 0.15;
    double roomHeight = MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + stacked + 60 /* header */);

    while((getCardHeight(width) + 10) *  3 > roomHeight){
      width -= 1;
    }
    return Size(width,getCardHeight(width));
  }

  double getCardHeight(double width) => (width * 13 ) / 9;

  BuildContext currentContext() => null;

  void notifyState(){}
}