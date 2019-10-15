import 'package:flutter/cupertino.dart';

class ClockTimerView{
  AnimationController _animationController;
  Animation _anim;

  Animation get anim => _anim;
  AnimationController get animationController => _animationController;

  int _bouncing = 0;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(vsync: tick, duration: const Duration(milliseconds: 200))
    ..addListener(notifyState)
    ..addStatusListener(onAnimationStatusListener);
    _anim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      curve: Curves.easeInOutBack,
      parent: _animationController
    ));
  }
  
  BuildContext currentContext() => null;
  
  void notifyState(){

  }
  
  void onAnimationStatusListener(AnimationStatus status){
    if(status == AnimationStatus.completed){
      _animationController.reverse();
    }else if(status == AnimationStatus.dismissed){
      if(_bouncing < 3){
        _bouncing++;
        _animationController.forward();
      }else{
        _bouncing = 0;
        _animationController.stop();
      }
    }
  }
}