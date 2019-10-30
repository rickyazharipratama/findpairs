import 'dart:async';

import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Lists/FinderLifesView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class FinderLifePresenter extends BaseComponentPresenter{

  FinderLifesView _view;
  FinderSumaryScore _summary; 
  StreamController<bool> _lifeLost = StreamController();

  FinderLifePresenter(){
    _summary = FinderSumaryScore();
  }
  
  FinderLifesView get view => _view;
  set setView(FinderLifesView vw){
    _view = vw;
  }
  int get life => _summary.life ?? 0;

  StreamSink<bool> get lifeLostSink => _lifeLost.sink;
  Stream<bool> get lifeLostStream => _lifeLost.stream;

  @override
  void initiateData() async{
    super.initiateData();
    await _summary.reconfigureLife();
    view.notifyState();
  }

  void dispose(){
    _lifeLost.close();
  }
}