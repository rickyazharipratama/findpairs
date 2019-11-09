import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/Items/SurvivalFrontCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/animation.dart';

class SurvivalFrontCardPresenter extends BaseComponentPresenter{

  final Stream<bool> shouldAnimatedStream;
  final StreamSink<bool> finishAnimSink;

  SurvivalFrontCardView _view;
  int _val;

  SurvivalFrontCardView get view => _view;
  set setView(SurvivalFrontCardView vw){
    _view = vw;
  }

  int get val => _val;
  set setVal(int vl){
    _val = vl;
  }

  SurvivalFrontCardPresenter({int value, this.shouldAnimatedStream, this.finishAnimSink}){
    _val = value;
    shouldAnimatedStream.listen(onListenAnimatedStream);
  }
  @override
  initiateData(){
    view.animationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        view.animationController.reset();
        finishAnimSink.add(true);
      }
    });
  }

  onListenAnimatedStream(bool isVal){
    if(isVal){
      view.animationController.forward(from: 0);
    }
  }

  void dispose(){
    view.animationController.dispose();
  }
}