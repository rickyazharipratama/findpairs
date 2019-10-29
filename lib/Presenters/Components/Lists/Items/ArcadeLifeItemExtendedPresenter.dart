import 'dart:async';

import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeLifeItemExtendedView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/SoundManager.dart';
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
    SoundManager.manager.play(
      player: FindPairsApp.of(view.currentContext()).presenter.particleSound,
      filename: "lost_life.mp3"
    );
    view.animationController.forward();
  }

  void onAnimationBouncer(AnimationStatus status){
    if(status == AnimationStatus.completed){
      view.animationController.reverse();
    }else if(status == AnimationStatus.dismissed){
      setLifeExtended = lifeExtended - 1;
      if(lifeExtended == 0){
        _disposeLifeExtended.add(true);
      }
    }
  }

  void dispose(){
    view.animationController.dispose();
  }
}