import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Modals/PauseMenuModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PauseActionButtonView{

  AnimationController _animationController;
  Animation _anim;

  AnimationController get animationController => _animationController;
  Animation get anim => _anim;


  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(vsync: tick, duration: const Duration(milliseconds: 250))
    ..addListener(notifyState)
    ..addStatusListener((status){
        if(status == AnimationStatus.completed){
          animationController.reverse();
        }
    });
    _anim = Tween<double>(begin: 1, end: 0.45).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceInOut
    ));
  }

  BuildContext currentContext() => null;

  Future<GamePauseType> openPauseMenu() async{
    return showDialog(
      context: currentContext(),
      barrierDismissible: false,
      builder: (context){
        return PauseMenuModal();
      }
    );
  }

  void notifyState(){}
}