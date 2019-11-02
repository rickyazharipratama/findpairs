import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/Items/FinderFlipCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class FinderFlipCardPresenter extends BaseComponentPresenter{

  final StreamSink<int> cardPairedSink;
  final Stream<Map<String,int>> valueChangeStream;
  final Stream<Map<String,int>> scoreAnimationStream;
  FinderFlipCardView _view;
  int val;
  int _scoreAnimation = 0;

  FinderFlipCardPresenter({this.cardPairedSink, this.val, this.valueChangeStream, this.scoreAnimationStream}){
    valueChangeStream.listen(onListenValueChange);
    scoreAnimationStream.listen(onListenScoreAnimation);
  }

  int get scoreAnimation => _scoreAnimation;

  @override
  initiateData(){

  }

  ontapCard(){
    cardPairedSink.add(val);
  }

  onListenScoreAnimation(Map<String,int> data){
    if(data['val'] == this.val){
      _scoreAnimation = data['score'];
      view.scoreAnimationController.forward();
    }
  }

  onListenValueChange(Map<String,int> data){
    print("value change : "+ data['old'].toString()+":"+this.val.toString()+" to "+data['new'].toString());
    if(data['old'] == this.val){
      this.val = data['new'];
      view.notifyState();
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