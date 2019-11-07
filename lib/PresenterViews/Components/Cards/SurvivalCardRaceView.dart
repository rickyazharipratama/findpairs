
import 'package:flutter/material.dart';

class SurvivalCardRaceView{

  AnimationController _animationController;
  Animation _firstCardAnimation;
  Animation _secondCardAnimation;
  Animation _thirdCardAnimation;

  double _finishLine() => MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + 60);

  AnimationController get animationController => _animationController;
  Animation get firstCardAnimation => _firstCardAnimation;
  Animation get secondCardAnimation => _secondCardAnimation;
  Animation get thirdCardAnimation => _thirdCardAnimation;

  set setAnimationController(Duration dur){
    _animationController = AnimationController(
      vsync: currentTicker(),
      duration: dur
    )
    ..addListener(notifyState);
  }

  set setFirstCardAnimation(double begin){
    _firstCardAnimation = Tween<double>(begin:begin, end: finishLine).animate(animationController);
  }

  set setSecondCardAnimation(double begin){
    _secondCardAnimation = Tween<double>(begin: begin, end: finishLine).animate(animationController);
  }

  set setThirdCardAnimation(double begin){
    _thirdCardAnimation = Tween<double>(begin: begin, end: finishLine).animate(animationController);
  }

  double get finishLine => _finishLine();
  double get restrictMoveLine => _finishLine() - (getCardHeight() * 2 ) - 10;
  double get compareLine => _finishLine() - getCardHeight() - 10;
  
TickerProvider currentTicker() => null;

double getCardHeight() => null;
double getCardWidth() => null;

BuildContext currentContext() => null;

void notifyState(){}
}