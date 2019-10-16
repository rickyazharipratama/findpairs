import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ArcadeLifeItemExtendedView{

  AnimationController _animationController;
  Animation _anim;

  Animation get anim => _anim;

  int _bouncing = 0;

  int get bouncing => _bouncing;
  set setBouncing(int bc){
    _bouncing = bc;
  }

  AnimationController get animationController => _animationController;
  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(vsync: tick, duration: const Duration(milliseconds: 100))
    ..addListener(notifyState);

    _anim = Tween<double>(begin: -0.02, end: 0.02).animate(CurvedAnimation(
      curve: Curves.easeInOutBack,
      parent: _animationController
    ));
  }

  BuildContext currentContext() => null;
  void notifyState (){}
}