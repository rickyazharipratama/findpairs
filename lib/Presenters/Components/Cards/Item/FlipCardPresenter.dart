import 'dart:async';

import 'package:findpairs/Models/ArcadeCardValue.dart';
import 'package:findpairs/PresenterViews/Components/Cards/Items/FlipCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/cupertino.dart';

class FlipCardPresenter extends BaseComponentPresenter{

  FlipCardView _view;
  Stream<int> _flipBack;
  Stream<bool> _restrictFlip;
  Stream<ArcadeTimer> _arcadeTime;
  StreamSink _streamSink;
  ArcadeCardValue _value;
  bool _isRestrictFLipCard = false;

  FlipCardPresenter(Stream<int> stream, StreamSink sink, Stream<bool> restrict,Stream<ArcadeTimer> at, ArcadeCardValue val){
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
  ArcadeCardValue get value => _value;
  set setValue(ArcadeCardValue val){
    _value= val;
  }
  
  @override
  void initiateData() {
    super.initiateData();
    view.setAnimationController = const Duration(milliseconds: 300);
    view.setVibrateController = const Duration(milliseconds: 100);
  }

  void onTapCard(){
    if(!view.isOpen){
      view.animationController.forward();
      view.setOpen = true;
      streamSink.add(value);
    }
  }

  needToFlipBack(int val){
    if(val == value.key){
      if(view.isOpen){
        debugPrint("flipping back: "+DateTime.now().millisecondsSinceEpoch.toString()+", with value: "+value.value.toString()+" & key: "+value.key.toString());
        view.setOpen = false;
        view.animationController.reverse();
      }
    }
  }

  onlisteningArcadeTimer(ArcadeTimer timer){
    debugPrint("start shaking");
    if(timer == ArcadeTimer.onAlmostTimeUp){
      if(!view.isStartShaking){
        view.setStartShaking = true;
        view.vibrateController.forward();
      }
    }else if(timer == ArcadeTimer.onTimeUp){
      _isRestrictFLipCard = true;
      view.setStartShaking = false;
      view.vibrateController.stop();
      view.notifyState();
    }else if(timer == ArcadeTimer.onTimeMustStop
    || timer == ArcadeTimer.onGameFinished){
      _isRestrictFLipCard = true;
      view.setStartShaking = false;
      view.vibrateController.stop();
      view.notifyState();
    }
  }

  reinitiateCard(){
    if(view.isOpen){
      view.animationController.reverse();
      view.setOpen = false;
    }
  }

  changeRestrictFlip(bool val){
    _isRestrictFLipCard = val;
    view.notifyState();
  }
}