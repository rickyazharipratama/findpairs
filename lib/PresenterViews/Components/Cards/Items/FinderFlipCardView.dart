import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart';

class FinderFlipCardView{

  AnimationController _animationController;

  AnimationController _shakingAnimationController;
  Animation shakingAnimation;


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

  AnimationController get animationController => _animationController;
  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 500)
    );
  }

  void notifyState(){}

  Vector3 shakingCard(double progress){
    Random rand = Random();
    double offset = rand.nextInt(4) * sin(progress * pi * 2);
    return Vector3(offset, offset,offset);
  }

}