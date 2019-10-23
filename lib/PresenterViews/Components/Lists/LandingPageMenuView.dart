import 'package:flutter/widgets.dart';

class LandingPageMenuView{

  PageController _controller;
  int _activePage = 0;


  double getCardHeight(){
    return MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + 180);
  }

  double getCardWidth(){
    return MediaQuery.of(currentContext()).size.width - 60;
  }

  PageController get controller => _controller;
  set setController(int active){
    _controller = PageController(
      initialPage: _activePage,
      keepPage: true,
      viewportFraction: 0.85
    );
  }

  int get activePage => _activePage;
  set setActivePage(int active){
    _activePage = active;
  }
  
  BuildContext currentContext() => null;

  void notifyState(){}

  void onPageChange(int page){
    setActivePage = page;
    notifyState();
  }
}