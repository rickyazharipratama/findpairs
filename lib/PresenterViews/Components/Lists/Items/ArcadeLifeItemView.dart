import 'dart:math';

import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ArcadeLifeItemView{

  AnimationController _animationController;
  Animation _animation;
  Animation _shakingAnimation;

  List<Color> _colors;

  AnimationController get animationController => _animationController;
  Animation get animation => _animation;
  Animation get shakingAnimation => _shakingAnimation;

  ExplodeType _explodeType;

  List<Color> get colors => _colors;
  ExplodeType get explodeType => _explodeType;


  setAnimationController(TickerProvider tick, ExplodeType type){
    _explodeType = type;
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 800)
    )..addListener(notifyState);
    _shakingAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0,0.3, curve: Curves.easeInBack)
    ));
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.3, 1, curve: type == ExplodeType.Spread ? Curves.linear : Curves.bounceOut )
    ));
  }

  set setColors(List<Color> cl){
    if(_colors == null){
      _colors = List();
    }else{
      _colors.clear();
    }
    _colors.addAll(cl);
  }


 Vector3 getShakingTranslation({
    double progress,
  }){
    double offset = 3 * sin(progress * pi * 2);
    return Vector3(offset, offset,offset);
  }

  void notifyState(){}

  BuildContext currentContext() => null;
}