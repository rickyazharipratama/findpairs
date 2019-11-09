import 'package:flutter/material.dart';

class SurvivalBottomPlacedView{

  AnimationController _animationController;
  Animation _anim;
  Animation get anim => _anim;

  int _counter = 0;

  set setCounter(int val){
    _counter = val;
  }
  int get counter => _counter;

  AnimationController get animationController => _animationController;

  setRightAnimation(){
    _anim = ColorTween(begin: Color(0xcc333333), end: Color(0xcc6eeb83)).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: _animationController
      )
    );
  }

  setWrongAnimation(){
    _anim = ColorTween(begin: Color(0xcc333333), end: Color(0xccc44317)).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: _animationController
      )
    );
  }

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 300)
    )
    ..addListener(notifyState)
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        animationController.reverse();
      }else if(status == AnimationStatus.dismissed){
        print("current counter : "+_counter.toString());
        if(_counter < 2){
          print("animation counter : "+_counter.toString());
          _counter++;
          animationController.forward();
        }else{
          _counter = 0;
        }
      }
    });
  }

  double wrapperHeight(double cardHeight){
    return cardHeight + 10 + MediaQuery.of(currentContext()).padding.bottom;
  }

  BuildContext currentContext() => null;

  void notifyState(){}
}