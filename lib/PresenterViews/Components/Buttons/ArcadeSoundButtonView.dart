import 'package:flutter/widgets.dart';

class ArcadeSoundButtonView{

  AnimationController _animationController;
  Animation _animation;


  AnimationController get animationController => _animationController;
  Animation get animation => _animation;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 500)
    )..addListener(notifyState)
    ..addStatusListener(listeningAnimationStatus);
  }
  
  void listeningAnimationStatus(AnimationStatus status){
    if(status == AnimationStatus.completed){
      _animationController.reverse();
    }
  }

  void notifyState(){}
  BuildContext currentContext() => null;
}