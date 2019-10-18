import 'package:findpairs/PresenterViews/Components/Buttons/ArcadeResultButtonView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/rendering.dart';

class ArcadeResultButtonPresenter extends BaseComponentPresenter{

  ArcadeResultButtonView _view;
  final String title;
  final VoidCallback callback;


  ArcadeResultButtonPresenter({this.title, this.callback});


  ArcadeResultButtonView get view => _view;
  set setView(ArcadeResultButtonView vw){
    _view = vw;
  }

  @override
  void initiateData() {
    super.initiateData();
  }


  void onTap(){
    view.animationController.forward();
    this.callback();
  }

  void dispose(){
    view.animationController.dispose();
  }

}