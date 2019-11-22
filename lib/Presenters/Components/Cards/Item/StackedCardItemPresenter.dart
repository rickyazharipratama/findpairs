import 'dart:async';

import 'package:findpairs/Models/Particles.dart';
import 'package:findpairs/PresenterViews/Components/Cards/Items/StackedCardItemView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:flutter/material.dart';

class StackedCardItemPresenter extends BaseComponentPresenter{

  final Stream<int> destroyCardStream;
  final StreamSink<bool> refillCardSink;
  final double cardWidth;
  final double cardHeight;
  int val;

  StackedCardItemView _view;

  List<Color> _colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.red,
    Colors.black,
    Colors.white,
    Colors.black,
    Colors.white
  ];

  Particles _particles;

  StackedCardItemPresenter({
    this.destroyCardStream,
    this.refillCardSink,
    this.cardWidth,
    this.cardHeight,
    this.val
  }){
    destroyCardStream.listen(onListenDestroyCard);
    _particles = Particles.generate(
      height: cardHeight,
      width: cardWidth,
      particleColors: _colors,
      totalParticle: 100
    );
  }

  StackedCardItemView get view => _view;
  set setView(StackedCardItemView vw){
    _view = vw;
  }

  Particles get particles => _particles;

  @override
  initiateData(){
    view.animationController.addStatusListener(onListenForStatusAnimation);
    view.notifyState();
  }

  onListenDestroyCard(int val){
    if(this.val == val){
      CommonUtil.instance.showLog(log:"value : "+val.toString());
      view.animationController.forward(from: 0);
    }
  }

  resetAnimate(){
    if(view.animationController.value > 0){
      view.animationController.reset();
      view.notifyState();
    }
  }

  onListenForStatusAnimation(AnimationStatus status){
    if(status == AnimationStatus.completed){
      refillCardSink.add(true);
    }
  }

  void dispose(){
    view.animationController.dispose();
  }
}