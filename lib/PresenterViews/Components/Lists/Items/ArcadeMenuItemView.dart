import 'package:findpairs/Widgets/Pages/SelectArcadeStage.dart';
import 'package:findpairs/Widgets/Pages/StagesPage.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:navigatorium/navigatorium.dart';

class ArcadeMenuItemView{

  AnimationController _controller;
  Animation _animationContinue;
  Animation _newgame;
  Animation _iconSlider;

  AnimationController get controller => _controller;
  Animation get animationContinue => _animationContinue;
  Animation get animationNewGame => _newgame;
  Animation get iconSlider => _iconSlider;

  setAnimationController(TickerProvider tick, double height){
    _controller = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 800)
    )..addListener(notifyState);

    _iconSlider = Tween<double>(begin: 0, end: height).animate(
      CurvedAnimation(
        curve: Interval(
          0.0,0.25,
          curve: Curves.bounceInOut
        ),
        parent: _controller
      )
    );
    _animationContinue = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0.2, 0.8,
          curve: Curves.bounceInOut
        ),
        parent: _controller
      )
    );
    _newgame = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0.4,1,
          curve: Curves.bounceInOut
        ),
        parent: _controller
      )
    );
  }

  Future<void> gotoStage(String episode, int stage) async{
    return Navigatorium.instance.push(currentContext(),
      child: StagesPage(
        stage: stage,
        episode: episode,
      )
    );
  }

  Future<void> goToSelectionStage() async{
    return Navigatorium.instance.push(currentContext(),
      child: SelectArcadeStage()
    );
  }

  BuildContext currentContext(){
    return null;
  }

  void notifyState(){

  }
}