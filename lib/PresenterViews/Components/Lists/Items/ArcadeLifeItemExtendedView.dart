import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ArcadeLifeItemExtendedView{

  AnimationController _animationController;
  Animation _anim;

  Animation get anim => _anim;

  AnimationController get animationController => _animationController;
  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(vsync: tick, duration: const Duration(milliseconds: 300))
    ..addListener(notifyState);

    _anim = Tween<double>(begin: -0.04, end: 0.04).animate(CurvedAnimation(
      curve: Curves.easeInOutBack,
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
  void notifyState (){}
}