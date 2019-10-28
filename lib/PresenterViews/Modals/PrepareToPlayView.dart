import 'package:findpairs/FindPairsApp.dart';
import 'package:flutter/widgets.dart';

class PrepareToPlayView{

  // 0 : ready
  // 1 : start
  int _messageMode = 0;
  String _message = "Ready";


  AnimationController _animationController;
  Animation _zoomOut;
  Animation _opct;


  int get messageMode => _messageMode;
  set setMessageMode(int val){
    _messageMode = val;
  }

  String get message => _message;

  AnimationController get animationController => _animationController;
  set setAnimationController(TickerProvider tick){
     _animationController = AnimationController(
       vsync: tick,
       duration: const Duration(milliseconds: 1000)
     )..addListener(notifyState)
     ..addStatusListener(listeningAnimationStatus);

    _zoomOut = Tween<double>(begin: 2.5, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0, 0.85,
          curve: Curves.bounceOut
        ),
        parent: _animationController
      )
    );

    _opct = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Interval(
          0,0.6,
          curve: Curves.easeIn
        ),
        parent: _animationController
      )
    );
  }

  Animation get zoomOut => _zoomOut;
  Animation get opct => _opct;

  void listeningAnimationStatus(AnimationStatus status){
    if(status == AnimationStatus.completed){
      if(messageMode == 0){
        setMessageMode = 1;
        FindPairsApp.of(currentContext()).presenter.sfxSound.play("start_arcade.mp3");
        _message = "Start";
        animationController.forward(from: 0);
      }else{
        Navigator.of(currentContext(), rootNavigator: true).pop(true);
      }
    }
  }


  BuildContext currentContext() => null;

  void notifyState(){}

}