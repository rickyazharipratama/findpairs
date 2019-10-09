import 'package:flutter/material.dart';

class LandingPageView{

  PageController _controller;
  
  int _activePage = 0;

  PageController get controller => _controller;
  set setController(int idx){
    _controller = PageController(
      initialPage: idx,
      keepPage: true,
      viewportFraction: 0.8
    );
  }

  int get activePage => _activePage;
  set setActivePage(int active){
    _activePage = active;
  }

  BuildContext currentContext() => null;

  void notifyState(){

  }
}