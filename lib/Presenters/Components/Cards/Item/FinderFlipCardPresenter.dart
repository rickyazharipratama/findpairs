import 'dart:async';

import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/PresenterViews/Components/Cards/Items/FinderFlipCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/SoundManager.dart';
import 'package:flutter/widgets.dart';

class FinderFlipCardPresenter extends BaseComponentPresenter{

  final StreamSink<int> cardPairedSink;
  final Stream<Map<String,int>> valueChangeStream;
  final Stream<Map<String,int>> scoreAnimationStream;
  final Stream<bool> restrictingCardStream;
  final VoidCallback forceRestrictCard;
  final VoidCallback forceOpenCard;
  FinderFlipCardView _view;
  int val;
  int updatedVal;
  bool isValueUpdated = false;
  int _scoreAnimation = 0;
  bool _isRestrictCard = false;

  FinderFlipCardPresenter({this.cardPairedSink, this.val, this.valueChangeStream, this.scoreAnimationStream, this.restrictingCardStream, this.forceRestrictCard, this.forceOpenCard}){
    valueChangeStream.listen(onListenValueChange);
    scoreAnimationStream.listen(onListenScoreAnimation);
    restrictingCardStream.listen(onListenRestrictionCard);
  }

  int get scoreAnimation => _scoreAnimation;

  set setRestrictCard(bool val){
    _isRestrictCard = val;
  }
  bool get isRestrictCard => _isRestrictCard;

  @override
  initiateData(){
    view.animationController..addStatusListener(onListeningAnimationControllerStatus);
    updatedVal = val;
  }

  ontapCard(){
    if(!isRestrictCard){
      forceRestrictCard();
      SoundManager.manager.play(
        player: FindPairsApp.of(view.currentContext()).presenter.particleSound,
        filename: "card_flip.mp3"
      );
      view.animationController.forward();
    }
  }


  onListeningAnimationControllerStatus(AnimationStatus status){
    if(status == AnimationStatus.completed){
      cardPairedSink.add(val);
      Future.delayed(
        const Duration(milliseconds: 600),
        (){
          view.animationController.reverse();
        }
      );
    }else if(status == AnimationStatus.dismissed){
      if(isValueUpdated){
        val = updatedVal;
        isValueUpdated = false;
      }
      forceOpenCard();
      view.notifyState();
    }
  }

  onListenScoreAnimation(Map<String,int> data){
    if(data['val'] == this.val){
      _scoreAnimation = data['score'];
      view.scoreAnimationController.forward();
    }
  }

  onListenRestrictionCard(bool isVal){
    setRestrictCard = isVal;
    print("restricted tap card val :"+this.val.toString());
  }

  onListenValueChange(Map<String,int> data){
    print("value change : "+ data['old'].toString()+":"+this.val.toString()+" to "+data['new'].toString());
    if(data['old'] == this.val){
      this.updatedVal = data['new'];
      this.isValueUpdated = true;
    }
  }

  FinderFlipCardView get view => _view;
  set setView(FinderFlipCardView vw){
    _view = vw;
  }

  void dispose(){
    view.animationController.dispose();
    view.shakingAnimationController.dispose();
    view.scoreAnimationController.dispose();
  }
}