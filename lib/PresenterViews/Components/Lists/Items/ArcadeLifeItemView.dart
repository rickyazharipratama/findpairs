import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ArcadeLifeItemView{

  AnimationController _animationController;
  Animation _animation;

  int _bouncing = 0;

  int _viewMode = 0;

  AnimationController get animationController => _animationController;
  Animation get animation => _animation;

  int get bouncing => _bouncing;

  int get viewMode => _viewMode;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 150)
    )..addListener(notifyState);
    _animation = Tween<double>(begin: -0.03, end: 0.03).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _animationController,
      )
    );
  }

  set setBouncing(int val){
    _bouncing = val;
  }

  set setViewMode(int val){
    _viewMode = val;
  }

  void notifyState(){}

  BuildContext currentContext() => null;
}