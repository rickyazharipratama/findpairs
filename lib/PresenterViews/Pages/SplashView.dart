import 'package:findpairs/Widgets/Pages/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:navigatorium/navigatorium.dart';

class SplashView{

  AnimationController _animationController;
  Animation _anim;
  Animation _opacity;

  AnimationController get animationController => _animationController;
  Animation get anim => _anim;
  Animation get opacity => _opacity;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 2000)
    )..addListener(notifyState);
    _anim = Tween<double>(begin: 3, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0, 0.85, curve: Curves.bounceOut
        ),
        parent: _animationController
      )
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0, 0.6, curve: Curves.ease
        ),
        parent: _animationController
      )
    );
  }

  void goToLandingPage(){
    Navigatorium.instance.newRoute(
      currentContext(),
      child: LandingPage()
    );
  }

  BuildContext currentContext() => null;
  void notifyState(){}

}