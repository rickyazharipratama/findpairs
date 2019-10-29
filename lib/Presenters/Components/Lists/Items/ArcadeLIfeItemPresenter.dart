import 'dart:async';
import 'dart:math';

import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/Models/Painters/ParticleModel.dart';
import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeLifeItemView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/SoundManager.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ArcadeLifeItemPresenter extends BaseComponentPresenter{

  ArcadeLifeItemView _view;
  int _tag;
  Stream<int> _lifeStream;
  StreamSink<bool> _lifeSinker;
  List<ParticleModel> _particles;
  final int particleConter = 50;

  ArcadeLifeItemPresenter(Stream<int> stream, StreamSink sinker,int tag){
    _tag = tag;
    _lifeStream = stream;
    _lifeSinker = sinker;
  }

  @override
  initiateData(){
    Random random = Random();
    view.setColors = [
      Colors.red,
      Colors.red,
      Color(0xff333333)
    ];
    _particles = List<ParticleModel>.generate(particleConter,(i){
      return ParticleModel(
        color: view.colors[i % view.colors.length],
        left: random.nextInt(30).toDouble(),
        top: random.nextInt(30).toDouble(),
        sizeFactor: random.nextInt(1000).toDouble()/1000,
        type: view.explodeType
      );
    });
    view.animationController.addStatusListener(onAnimationStatusListener);
    _lifeStream.listen(onListenLifeStream);
  }

  List<ParticleModel> get particles => _particles;

  ArcadeLifeItemView get view => _view;
  set setView(ArcadeLifeItemView vw){
    _view = vw;
  }

  int get tag => _tag;

  void onListenLifeStream(int val){
    print("=====");
    print(val.toString()+" : "+_tag.toString());
    print("=======");

    if(val == _tag){
      explode();
    }
  }

  void explode(){
    if(view.animationController.isDismissed){
      SoundManager.manager.play(
        player: FindPairsApp.of(view.currentContext()).presenter.particleSound,
        filename: "lost_life.mp3"
      );
      view.animationController.reset();
      view.animationController.forward();
      

    }
  }

  void onAnimationStatusListener(AnimationStatus status){
    if(status == AnimationStatus.completed){
      _lifeSinker.add(true);
    }
  }

  dispose(){
    view.animationController.dispose();
  }
}