import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/Items/FlipCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/cupertino.dart';

class FlipCardPresenter extends BaseComponentPresenter{

  FlipCardView _view;
  Stream<String> _flipBack;
  Stream<bool> _restrictFlip;
  Stream<ArcadeTimer> _arcadeTime;
  StreamSink _streamSink;
  String _value;
  bool _isRestrictFLipCard = false;

  FlipCardPresenter(Stream<String> stream, StreamSink sink, Stream<bool> restrict,Stream<ArcadeTimer> at, String val){
    _flipBack = stream;
    _flipBack.listen(needToFlipBack);
    _streamSink = sink;
    _value = val;
    _restrictFlip = restrict;
    _restrictFlip.listen(changeRestrictFlip);
    _arcadeTime = at;
    _arcadeTime.listen(onlisteningArcadeTimer);
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
    view.setVibrateController = const Duration(milliseconds: 100);
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

  onlisteningArcadeTimer(ArcadeTimer timer){
    debugPrint("start shaking");
    if(timer == ArcadeTimer.onAlmostTimeUp){
      view.vibrateController.forward();
    }else if(timer == ArcadeTimer.onTimeUp){
      _isRestrictFLipCard = true;
      view.vibrateController.stop();
      view.notifyState();
    }
  }

  changeRestrictFlip(bool val){
    _isRestrictFLipCard = val;
    view.notifyState();
  }
}