import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/PresenterViews/Pages/SplashView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:flutter/material.dart';

class SplashPresenter extends BasePagePresenter{

  SplashView _view;
  bool isLoadAsset = false;

  SplashView get view => _view;
  set setView(SplashView vw){
    _view = vw;
  }

  @override
  void initiateData() {
    super.initiateData();
    view.animationController.addStatusListener(listeningStatusAnimation);
    view.animationController.forward(from: 0);
  }


  listeningStatusAnimation(AnimationStatus status){
    if(status == AnimationStatus.completed){
      isLoadAsset = true;
      view.notifyState();
      Future.delayed(
        const Duration(milliseconds: 500),
        () async{
          await FindPairsApp.of(view.currentContext()).presenter.loadingSound();
          view.goToLandingPage();
        }
      );
    }  
  }

  void dispose(){
    view.animationController.dispose();
  }
}