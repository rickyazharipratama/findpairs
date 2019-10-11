import 'package:flutter/widgets.dart';

class FlipCardView{

  AnimationController _animationController;
  Animation<double> _animation;

  bool _isOpen = false;


  AnimationController get animationController => _animationController;
  Animation<double> get animation => _animation;

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

  TickerProvider ticker(){
    return null;
  }

  BuildContext currentContext() => null;


  void notifyState(){

  }

}