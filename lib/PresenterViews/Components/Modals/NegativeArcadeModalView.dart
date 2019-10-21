import 'package:flutter/widgets.dart';

class NegativeArcadeModalView{

  double _width;
  double _height;
  double _wrapperWidth;
  double _wrapperHeight;

  AnimationController _animationController;
  Animation _animation;
  Animation _animButton;


  double get width => _width;
  double get height => _height;

  double get wrapperWidth => _wrapperWidth;
  double get wrapperHeight => _wrapperHeight;

  set setWidth(double halfWidth){
    _width = halfWidth + (halfWidth / 2) + (halfWidth / 2) / 2;
  }
  set setHeight(double width){
    _height = (width / 16) * 11;
  }
  set setWrapperWidth(double width){
    _wrapperWidth =  width - 30;
  }
  set setWrapperHeight(double height){
    _wrapperHeight = height - 40;
  }

  AnimationController get animationController => _animationController;
  Animation get animation => _animation;
  Animation get animButton => _animButton;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 350)
    )..addListener(notifyState);

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      curve: Interval(
        0,0.7,
        curve: Curves.bounceInOut
      ),
      parent: _animationController
    ));

    _animButton = Tween<double>(begin: 0, end:  1).animate(
      CurvedAnimation(
        curve: Interval(
          0.7,1,
          curve: Curves.bounceInOut
        ),
        parent: _animationController
      )
    );
  }

  BuildContext currentContext() => null;

  void notifyState(){

  }
}