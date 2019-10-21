import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CompleteArcadeModalView{

  AnimationController _animationController;
  Animation _animation;
  Animation _star1;
  Animation _star2;
  Animation _star3;
  Animation _animButton;

  double _width;
  double _height;
  double _wrapperWidth;
  double _wrapperHeight;

  double get width => _width;
  double get height => _height;

  double get wrapperWidth => _wrapperWidth;
  double get wrapperHeight => _wrapperHeight;

  set setWidth(double halfWidth){
    _width = halfWidth + (halfWidth / 2) + (halfWidth / 2) / 2;
  }
  set setHeight(double width){
    _height = (width / 16) * 12;
  }
  set setWrapperWidth(double width){
    _wrapperWidth =  width - 30;
  }
  set setWrapperHeight(double height){
    _wrapperHeight = height - 90;
  }

  AnimationController get animationController => _animationController;
  Animation get animation => _animation;
  Animation get star1 => _star1;
  Animation get star2 => _star2;
  Animation get star3 => _star3;
  Animation get animButton => _animButton;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 1000)
    )..addListener(notifyState);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0.0, 0.2,
          curve: Curves.bounceInOut
        ),
        parent: _animationController
      )
    );
    _star1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0.25,0.5,
          curve: Curves.bounceInOut
        ),
        parent: _animationController
      )
    );
    _star2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0.45,0.7,
          curve: Curves.bounceInOut
        ),
        parent: _animationController
      )
    );
    _star3 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0.65,0.9,
          curve: Curves.bounceInOut
        ),
        parent: _animationController
      )
    );

    _animButton = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0.9,1.0,
          curve: Curves.bounceInOut
        ),
        parent: _animationController
      )
    );
  }

  BuildContext currentContext() => null;

  void notifyState(){}
}