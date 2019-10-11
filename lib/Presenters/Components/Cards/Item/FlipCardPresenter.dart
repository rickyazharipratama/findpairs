import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/Items/FlipCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/cupertino.dart';

class FlipCardPresenter extends BaseComponentPresenter{

  FlipCardView _view;
  Stream<String> _flipBack;
  StreamSink _streamSink;
  String _value;

  FlipCardPresenter(Stream<String> stream, StreamSink sink, String val){
    _flipBack = stream;
    _flipBack.listen(needToFlipBack);
    _streamSink = sink;
    _value = val;
  }

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
}