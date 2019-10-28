import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class PauseMenuModalView{

  AnimationController _animationController;
  Animation _animation;


  AnimationController get animationController => _animationController;
  Animation get animation => _animation;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(vsync: tick, duration: const Duration(milliseconds: 700))
    ..addListener(notifyState);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Curves.bounceInOut,
        parent: _animationController
      )
    );
  }

  void notifyState(){}
}