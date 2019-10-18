import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';

class ArcadeResultButtonView{

  AnimationController _animationController;
  Animation _animation;

  AnimationController get animationController => _animationController;
  Animation get animation => _animation;


  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 200)
    )..addListener(notifyState)
    ..addStatusListener(animationStatusListener);
    _animation = Tween<double>(begin: 1, end: 0.7).animate(
      CurvedAnimation(
        curve: Curves.easeInBack,
        parent: _animationController
      )
    );
  }

  void notifyState(){}

  void animationStatusListener(AnimationStatus status){
    if(status == AnimationStatus.completed){
      _animationController.reverse();
    }
  }
}