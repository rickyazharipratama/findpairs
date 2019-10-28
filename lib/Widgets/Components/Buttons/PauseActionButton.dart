import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Buttons/PauseActionButtonView.dart';
import 'package:findpairs/Presenters/Components/Buttons/PauseActionButtonPresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/material.dart';

class PauseActionButton extends StatefulWidget {
  final Color color;
  final StreamSink<GamePauseType> sinker;

  PauseActionButton({this.color : Colors.white, @required this.sinker});

  @override
  _PauseActionButtonState createState() => new _PauseActionButtonState();
}

class _PauseActionButtonState extends State<PauseActionButton> with SingleTickerProviderStateMixin,PauseActionButtonView{

  PauseActionButtonPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = PauseActionButtonPresenter(widget.sinker)..setView = this;
    setAnimationController = this;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: presenter.onIconHasTapped,
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Transform.scale(
            scale: anim.value,
            child: Icon(
              Icons.pause,
              color: widget.color,
              size : 40
            ),
          ),
        ),
      ),
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  void notifyState(){
    if(mounted){
      setState(() {
        
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}