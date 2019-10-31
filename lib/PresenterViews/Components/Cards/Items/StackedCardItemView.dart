import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart';

class StackedCardItemView{

  AnimationController _animationController;
  Animation _shakingAnimation;
  Animation _destroyAnimation;

  AnimationController get animationController => _animationController;
  Animation get shakingAnimation => _shakingAnimation;
  Animation get destroyAnimation => _destroyAnimation;


  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 500)
    )..addListener(notifyState);
    _shakingAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      curve: Interval(
        0,0.4,
        curve: Curves.bounceInOut
      ),
      parent: _animationController
    ));
    _destroyAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      curve: Interval(
        0.4,1,
        curve: Curves.bounceInOut
      ),
      parent: _animationController
    ));
  }

  Vector3 getShakingTranslation({
    double progress,
  }){
    double offset = 3 * sin(progress * pi * 2);
    return Vector3(offset, offset,offset);
  }

  BuildContext currentContext() => null;
  void notifyState(){}

}