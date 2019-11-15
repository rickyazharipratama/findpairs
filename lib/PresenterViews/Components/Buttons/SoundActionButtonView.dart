import 'package:flutter/material.dart';

class SoundActionButtonView{

  AnimationController _animationController;
  Animation _animation;

  AnimationController get animationController => _animationController;
  Animation get animation => _animation;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(
        milliseconds: 300
      )
    )
    ..addListener(notifyState);

    _animation = Tween<double>(begin: 0, end: 40).animate(
      CurvedAnimation(
        curve: Curves.bounceInOut,
        parent: _animationController
      )
    );
  }

  BuildContext currentContext() => null;

  void notifyState(){}
  
}