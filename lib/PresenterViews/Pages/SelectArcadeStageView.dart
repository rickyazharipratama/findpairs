import 'package:flutter/cupertino.dart';

class SelectArcadeStageView{

  int _viewMode = 0;
  int _activeIndex = 0;
  PageController _pageController;

  int get viewMode => _viewMode;
  set setViewMode(int val){
    _viewMode = val;
  }

  int get activeIndex => _activeIndex;
  set setActiveIndex(int val){
    _activeIndex = val;
  }

  PageController get pageController => _pageController;
  set setPageController(int initaliPge){
    _pageController = PageController(
      initialPage: initaliPge,
      keepPage: true,  
    );
  }

  double getStageWidth(){
    return (MediaQuery.of(currentContext()).size.width - 50) / 3;
  }

  double getStageHeight(){
    return (getStageWidth() * 16) / 9;
  }


  closePage(){
    Navigator.of(currentContext()).pop();
  }

  BuildContext currentContext() => null;

  notifyState(){}


}