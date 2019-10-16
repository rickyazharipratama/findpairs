import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeLifeItemView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/animation.dart';

class ArcadeLifeItemPresenter extends BaseComponentPresenter{

  ArcadeLifeItemView _view;
  int _tag;
  Stream<int> _lifeStream;
  StreamSink<bool> _lifeSinker;

  ArcadeLifeItemPresenter(Stream<int> stream, StreamSink sinker,int tag){
    _tag = tag;
    _lifeStream = stream;
    _lifeSinker = sinker;
  }

  @override
  initiateData(){
    view.animationController.addStatusListener(onBouncingAnimate);
    _lifeStream.listen(onListenLifeStream);
  }

  ArcadeLifeItemView get view => _view;
  set setView(ArcadeLifeItemView vw){
    _view = vw;
  }

  void onListenLifeStream(int val){
    print("=====");
    print(val.toString()+" : "+_tag.toString());
    print("=======");

    if(val == _tag){
      view.animationController.forward();
    }
  }

  void onBouncingAnimate(AnimationStatus status){
    if(status == AnimationStatus.completed){
      view.animationController.reverse();
    }else if(status == AnimationStatus.dismissed){
      if(view.bouncing < 4){
        view.setBouncing = view.bouncing + 1;
        view.animationController.forward();
      }else{
        view.animationController.stop();
        view.setBouncing = 0;
        _lifeSinker.add(true);
      }
    }
  }

  dispose(){
    view.animationController.dispose();
  }
}