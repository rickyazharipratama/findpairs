import 'package:flutter/material.dart';
import 'dart:math';

class SettingActionButtonView{
  AnimationController _animController;
  Animation _anim;

  AnimationController get animController => _animController;
  set setAnimationController(TickerProvider tick){
    _animController = AnimationController(vsync: tick, duration: const Duration(milliseconds: 700))
    ..addListener(notifyState)
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        _animController.reverse();
      }
    }); 
  }

  Animation get anim => _anim;
  set setAnim(AnimationController controller){
    _anim = Tween<double>(begin: 0 , end: 1).animate(CurvedAnimation(curve: Curves.ease, parent: controller));
  }

  double getAnimatedAngle() => anim.value * pi;

  BuildContext currentContext() => null;
  void notifyState(){}
}