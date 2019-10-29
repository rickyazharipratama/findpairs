import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/LandingPageMenuView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';

class LandingPageMenuPresenter extends BaseComponentPresenter{

  final List<Map<String,dynamic>> menus = ConstantCollections.MENUS;
  final StreamController streamController;
  LandingPageMenuView _view;

  LandingPageMenuPresenter({this.streamController});

  LandingPageMenuView get view => _view;
  set setView( LandingPageMenuView vw){
    _view = vw;
  }

  @override
  void initiateData() {
    super.initiateData();
    view.setController = view.activePage;
    streamController.sink.add(menus[0]);
  }

  onPageChanged(int page){
    streamController.sink.add(menus[page]);
    view.onPageChange(page);
  }
}