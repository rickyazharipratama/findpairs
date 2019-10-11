import 'package:flutter/material.dart';

class CardView{

  BuildContext currentContext() => null;

  double getWidth() => MediaQuery.of(currentContext()).size.width-20;
  double getHeight() => MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + 300);

  double getCardWidth(int horizontal, int vertical){

    double cardWidth = (getWidth() / horizontal) - 10;
    double tempHeight = getCardHeight(cardWidth);
    double totalTempHeight = (tempHeight+10) * vertical;

    while (totalTempHeight >= getHeight()){
      cardWidth-= 2;
      totalTempHeight = (getCardHeight(cardWidth) + 10) * vertical;
    }
    return cardWidth;
  }
  double getCardHeight(double width) => (width * 13 ) / 9;

}