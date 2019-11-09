import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Modals/CompleteArcadeModal.dart';
import 'package:findpairs/Widgets/Modals/NegativeArcadeModal.dart';
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

  Future<ArcadeAction> showCompleteDialog({
    int star,
    String message,
    String episode
  }) async{
    return await showDialog(
      context:  currentContext(),
      barrierDismissible:  false,
      builder: (context) => CompleteArcadeModal(
        starScore: star,
        episode: episode,
        message: message,
        negativeText: "EXIT",
        positiveText: "RETRY",
      )
    );
  }

  Future<ArcadeAction> showNegativeDialog({
    String title,
    String episode
  }) async{
    return await showDialog(
      context: currentContext(),
      barrierDismissible: false,
      builder: (context) => NegativeArcadeModal(
        message: title,
        episode: episode,
      )
    );
  }

  double getCardHeight(double width) => (width * 13 ) / 9;

  BuildContext currentContext() => null;

  void notifyState(){}
}