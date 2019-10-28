import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Modals/CompleteArcadeModal.dart';
import 'package:findpairs/Widgets/Modals/NegativeArcadeModal.dart';
import 'package:findpairs/Widgets/Modals/PrepareToPlayModal.dart';
import 'package:findpairs/Widgets/Pages/ArcadeSeeYouNextEpisode.dart';
import 'package:flutter/material.dart';

class CardView{

  BuildContext currentContext() => null;

  void notifyState(){}

  double getWidth() => MediaQuery.of(currentContext()).size.width-20;
  double getHeight() => MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + 180);

  double getCardWidth(int horizontal, int vertical){

    double cardWidth = ((getWidth() - (10 * horizontal)) / horizontal);
    double tempHeight = getCardHeight(cardWidth);
    double totalTempHeight = (tempHeight+10) * vertical;
    print("total temp height : "+totalTempHeight.toString());
    print("space height : "+ getHeight().toString());

    while (totalTempHeight >= getHeight()){
      cardWidth-= 2;
      totalTempHeight = (getCardHeight(cardWidth) + 10) * vertical;
      print("total temp height : "+totalTempHeight.toString());
    }
    return cardWidth;
  }
  double getCardHeight(double width) => (width * 13 ) / 9;

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

  void closeView(){
    Navigator.of(currentContext()).pop();
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
      )
    );
  }

  Future<bool> prepareToPlay() async{
    return await showDialog(
      context: currentContext(),
      barrierDismissible: false,
      builder: (context) => PrepareToPlay()
    );
  }

  void goToClosingArcade(){
    Navigator.of(currentContext()).pop();
    Navigator.of(currentContext()).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context){
          return ArcadeSeeYouNextEpisode();
        }
      )
    );
  }
}