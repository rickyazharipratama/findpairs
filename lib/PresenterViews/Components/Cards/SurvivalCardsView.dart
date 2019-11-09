import 'package:findpairs/Widgets/Modals/PrepareToPlayModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SurvivalCardsView{

  BuildContext currentContext() => null;

  Future<bool> prepareToPlay() async{
    return await showDialog(
      context: currentContext(),
      barrierDismissible: false,
      builder: (context) => PrepareToPlay()
    );
  }

  void notifyState(){}
}