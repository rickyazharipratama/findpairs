import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/Items/FinderFlipCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class FinderFlipCardPresenter extends BaseComponentPresenter{

  final StreamSink<int> cardPairedSink;
  final Stream<Map<String,int>> valueChangeStream;
  FinderFlipCardView _view;
  int val;

  FinderFlipCardPresenter({this.cardPairedSink, this.val, this.valueChangeStream}){
    valueChangeStream.listen(onListenValueChange);
  }

  @override
  initiateData(){

  }

  ontapCard(){
    cardPairedSink.add(val);
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
  }
}