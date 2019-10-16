import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeLifeItemExtendedView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/cupertino.dart';

class ArcadeLifeItemExtendedPresenter extends BaseComponentPresenter{

  ArcadeLifeItemExtendedView _view;
  StreamSink<bool> _disposeLifeExtended;
  Stream<int> _lifeExtendedStream;
  int _lifeExtended;
  
  int get lifeExtended => _lifeExtended;
  set setLifeExtended(int val){
    _lifeExtended = val;
  }
  ArcadeLifeItemExtendedView get view => _view;

  set setView(ArcadeLifeItemExtendedView vw){
    _view = vw;
  } 

  ArcadeLifeItemExtendedPresenter(int life, StreamSink<bool> sinker, Stream<int> stream){
    setLifeExtended = life;
    _disposeLifeExtended = sinker;
    _lifeExtendedStream = stream;
    _lifeExtendedStream.listen(onListenExtendedLife);
  }

  @override
  void initiateData() {
    super.initiateData();
    view.animationController.addStatusListener(onAnimationBouncer);
  }

  void onListenExtendedLife(int life){
    view.animationController.forward();
  }

  void onAnimationBouncer(AnimationStatus status){
    if(status == AnimationStatus.completed){
      view.animationController.reverse();
    }else if(status == AnimationStatus.dismissed){
      if(view.bouncing < 3){
        view.animationController.forward();
        view.setBouncing = view.bouncing+1;
      }else{
        view.animationController.stop();
        view.setBouncing = 0;
        setLifeExtended = lifeExtended - 1;
        if(lifeExtended == 0){
          _disposeLifeExtended.add(true);
        }else{
          view.notifyState();
        }
      }
    }
  }

  void dispose(){
    view.animationController.dispose();
  }
}