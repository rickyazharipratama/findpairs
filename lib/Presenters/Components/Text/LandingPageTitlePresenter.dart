import 'package:findpairs/PresenterViews/Components/Text/LandingPageTitleView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class LandingPageTitlePresenter extends BaseComponentPresenter{

  LandingPageTitleView _view;
  Stream<Map<String,dynamic>> _stream;
  Map<String,dynamic> _title;

  final List<String> texts = [
    ""," ","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
  ];
  List<Map<String,dynamic>> _animatedChars = List();

  LandingPageTitlePresenter(Stream str){
    _stream = str;
    _stream.listen(onReceiveSinker);
  }

  LandingPageTitleView get view => _view;
  set setView(LandingPageTitleView vw){
    _view = vw;
  }

  Map<String,dynamic> get title => _title;
  set setTitle(Map<String,dynamic> ttl){
    _title = ttl;
  }

  List<Map<String,dynamic>> get animatedChars => _animatedChars;

  @override
  initiateData(){
    super.initiateData();
    setupTextAnimation("".split(""), "".split(""),Colors.transparent, Colors.transparent);
  }

  onReceiveSinker(Map<String,dynamic> data){
    debugPrint("receive broadcast : "+data['name'].toString());
    String oldTitle = "";
    Color oldColor  = Colors.red;
    if(title != null){
      oldTitle = title['name'];
      oldColor = title['color'];
    }
    String newTitle = data['name'];
    Color newColor = data['color'];
    setTitle = data;
    view.notifyState();
    clearAnimationController();

    setupTextAnimation(newTitle.split(''), oldTitle.split(''), oldColor, newColor);
  }

  setupTextAnimation(List<String> newText, List<String> oldtext, Color oldColor, Color newColor){
    int greater = max(newText.length, oldtext.length);
    for(int i = 0; i < greater ; i++){
      AnimationController controller = AnimationController(
        duration: Duration(milliseconds: 450), vsync: view.tick
      )..addListener(view.notifyState);
      StepTween tween = StepTween(
        begin: i > oldtext.length - 1 ? 0: texts.indexOf(oldtext[i]),
        end:  i > newText.length - 1 ? 0 : texts.indexOf(newText[i])
      );
      ColorTween colorTween = ColorTween(
        begin: oldColor,
        end: newColor
      );
      animatedChars.add({
        "animationController": controller,
        "tween":tween,
        "color":colorTween
      });
      controller.forward();
    }
  }

  clearAnimationController(){
    animatedChars.forEach((f){
      f['animationController'].dispose();
    });
    animatedChars.clear();
  }
}