import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/Items/FlipCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/cupertino.dart';

class FlipCardPresenter extends BaseComponentPresenter{

  FlipCardView _view;
  Stream<String> _flipBack;
  Stream<bool> _restrictFlip;
  StreamSink _streamSink;
  String _value;
  bool _isRestrictFLipCard = false;

  FlipCardPresenter(Stream<String> stream, StreamSink sink, Stream<bool> restrict, String val){
    _flipBack = stream;
    _flipBack.listen(needToFlipBack);
    _streamSink = sink;
    _value = val;
    _restrictFlip = restrict;
    _restrictFlip.listen(changeRestrictFlip);
  }

  bool get isRestrictFlipCard => _isRestrictFLipCard;

  FlipCardView get view => _view;
  set setView(FlipCardView vw){
    _view = vw;
  }

  StreamSink get streamSink => _streamSink;
  String get value => _value;
  
  @override
  void initiateData() {
    super.initiateData();
    view.setAnimationController = const Duration(milliseconds: 500);
  }

  void onTapCard(){
    if(!view.isOpen){
      view.animationController.forward();
      view.setOpen = true;
      streamSink.add(value);
    }
  }

  needToFlipBack(String val){
    if(val == this.value){
      if(view.isOpen){
        debugPrint("flipping back: "+DateTime.now().millisecondsSinceEpoch.toString()+", with value: "+val);
        view.setOpen = false;
        view.animationController.reverse();
      }
    }
  }

  changeRestrictFlip(bool val){
    _isRestrictFLipCard = val;
    view.notifyState();
  }
}