import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

class FlipCardView{

  AnimationController _animationController;
  Animation<double> _animation;

  AnimationController _vibrateController;
  Animation<double> _vibrateAnimation;

  bool _isOpen = false;
  bool _isStartShaking = false;

  AnimationController get animationController => _animationController;
  Animation<double> get animation => _animation;

  AnimationController get vibrateController => _vibrateController;
  Animation<double> get vibrateAnimation => _vibrateAnimation;

  set setVibrateController(Duration dur){
    _vibrateController = AnimationController(
      vsync: ticker(),
      duration: dur
    )..addListener(notifyState)
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        vibrateController.reverse();
      }else if(status == AnimationStatus.dismissed){
        vibrateController.forward();
      }
    });
    _vibrateAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Curves.easeInOutBack,
        parent: _vibrateController
      )
    );
  }

  Vector3 getShakingTranslation({
    double progress,
  }){
    Random rand = Random();
    double offset = rand.nextInt(3) + 1 * sin(progress * pi * (rand.nextInt(3) + 1));
    return Vector3(offset, offset,offset);
  }

  set setAnimationController(Duration duration){
    _animationController = AnimationController(
       vsync: ticker(),
       duration: duration,
    )..addListener(notifyState);
     _animation = CurvedAnimation(
      curve: Curves.ease,
      parent: _animationController,
    );
  }

  bool get isOpen => _isOpen;
  set setOpen(bool val){
    _isOpen = val;
  }

  bool get isStartShaking => _isStartShaking;
  set setStartShaking(bool val){
    _isStartShaking = val;
  }

  TickerProvider ticker(){
    return null;
  }

  BuildContext currentContext() => null;


  void notifyState(){

  }
}