import 'package:flutter/material.dart';

class SurvivalFrontCardView{

  AnimationController _animationController;
  Animation _anim;

  AnimationController get animationController => _animationController;
  Animation get anim =>_anim;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 300)
    )
    ..addListener(notifyState);
    _anim = Tween<double>(begin: getBottom() , end: (getBottom() - (getCardHeight() + 10))).animate(CurvedAnimation(
      curve: Curves.ease,
      parent: animationController
    ));
  }

  double getBottom() => null;
  double getCardHeight() => null;

  BuildContext currentContext() => null;

  void notifyState(){}

}