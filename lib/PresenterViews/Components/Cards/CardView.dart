import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Modals/NegativeArcadeModal.dart';
import 'package:flutter/material.dart';

class CardView{

  BuildContext currentContext() => null;

  void notifyState(){}

  double getWidth() => MediaQuery.of(currentContext()).size.width-20;
  double getHeight() => MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + 260);

  double getCardWidth(int horizontal, int vertical){

    double cardWidth = (getWidth() / horizontal);
    double tempHeight = getCardHeight(cardWidth);
    double totalTempHeight = (tempHeight+10) * vertical;

    while (totalTempHeight >= getHeight()){
      cardWidth-= 2;
      totalTempHeight = (getCardHeight(cardWidth) + 10) * vertical;
    }
    return cardWidth;
  }
  double getCardHeight(double width) => (width * 13 ) / 9;

  Future<ArcadeAction> showNegativeDialog({
    String title,
  }) async{
    return await showDialog(
      context: currentContext(),
      barrierDismissible: false,
      builder: (context) => NegativeArcadeModal()
    );
  }

  void closeView(){
    Navigator.of(currentContext()).pop();
  }

}