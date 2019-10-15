import 'package:flutter/cupertino.dart';

class PauseActionButtonView{

  AnimationController _animationController;
  Animation _anim;

  AnimationController get animationController => _animationController;
  Animation get anim => _anim;


  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(vsync: tick, duration: const Duration(milliseconds: 250))
    ..addListener(notifyState)
    ..addStatusListener((status){
        if(status == AnimationStatus.completed){
          animationController.reverse();
        }
    });
    _anim = Tween<double>(begin: 1, end: 0.45).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceInOut
    ));
  }

  BuildContext currentContext() => null;

  void notifyState(){}
}