import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart';

class FinderFlipCardView{

  AnimationController _animationController;

  AnimationController _shakingAnimationController;
  Animation shakingAnimation;

  AnimationController _scoreAnimationController;
  Animation<double> _scoreOpacityAnimation;
  Animation<double> _scoreTranslateAnimation;

  AnimationController get shakingAnimationController => _shakingAnimationController;
  set setShakingAnimationController(TickerProvider tick){
    _shakingAnimationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 1000)
    );
    shakingAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Curves.bounceInOut,
        parent: _shakingAnimationController
      )
    );
  }

  AnimationController get scoreAnimationController => _scoreAnimationController;
  Animation<double> get scoreOpacityAnimation => _scoreOpacityAnimation;
  Animation<double> get scoreTranslateAnimation => _scoreTranslateAnimation;


  AnimationController get animationController => _animationController;
  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 500)
    );
  }

  set setScoreAnimationController(TickerProvider tick){
    _scoreAnimationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 500)
    )
    ..addListener(notifyState)
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        _scoreAnimationController.reset();
        notifyState();
      }
    });
    _scoreOpacityAnimation = Tween<double>(begin: 0, end: 1)
    .animate(CurvedAnimation(
      curve: Interval(
        0,0.8,
        curve: Curves.ease
      ),
      parent: scoreAnimationController
    ));

    _scoreTranslateAnimation = Tween<double>(begin: getCardHeight() / 3, end: getCardHeight() / 4.5)
    .animate(CurvedAnimation(
      curve: Curves.ease,
      parent: scoreAnimationController
    ));
  }

  BuildContext currentContext() => null;

  void notifyState(){}

  Vector3 shakingCard(double progress){
    Random rand = Random();
    double offset = rand.nextInt(4) * sin(progress * pi * 2);
    return Vector3(offset, offset,offset);
  }

  double getCardHeight() => null;

}