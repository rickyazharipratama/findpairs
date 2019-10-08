
import 'dart:async';

import 'package:findpairs/PresenterViews/Pages/LandingPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';

class LandingPagePresenter extends BasePagePresenter{

  LandingPageView _view;
  StreamController<Map<String,dynamic>> _streamController;


  StreamController get streamController => _streamController;

  Stream<Map<String,dynamic>> get stream => _streamController.stream;

  LandingPageView get view => _view;
  set setView(LandingPageView vw){
    _view = vw;
  }

  LandingPagePresenter(){
    _streamController = StreamController();
  }

  void disposingStream(){
    _streamController.close();
  }

  @override
  void initiateData() {
    super.initiateData();

  }
}