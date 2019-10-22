import 'package:findpairs/Widgets/Pages/SelectArcadeStage.dart';
import 'package:findpairs/Widgets/Pages/StagesPage.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ArcadeMenuItemView{

  AnimationController _controller;
  Animation _animationContinue;
  Animation _newgame;

  AnimationController get controller => _controller;
  Animation get animationContinue => _animationContinue;
  Animation get animationNewGame => _newgame;

  set setAnimationController(TickerProvider tick){
    _controller = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 500)
    )..addListener(notifyState);
    _animationContinue = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0,0.8,
          curve: Curves.bounceInOut
        ),
        parent: _controller
      )
    );
    _newgame = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0.2,1,
          curve: Curves.bounceInOut
        ),
        parent: _controller
      )
    );
  }

  void gotoStage(String episode, int stage){
    Navigator.of(currentContext()).push(MaterialPageRoute(
      builder: (context) => StagesPage(stage: stage, episode: episode)
    ));
  }

  void goToSelectionStage(){
    Navigator.of(currentContext()).push(MaterialPageRoute(
      builder: (context) => SelectArcadeStage()
    ));
  }

  BuildContext currentContext(){
    return null;
  }

  void notifyState(){

  }
}