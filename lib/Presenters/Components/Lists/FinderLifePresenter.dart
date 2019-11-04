import 'dart:async';

import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Lists/FinderLifesView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/SoundManager.dart';

class FinderLifePresenter extends BaseComponentPresenter{

  final Stream<int> lifeConfigurationStream;

  FinderLifesView _view;
  FinderSumaryScore _summary; 
  StreamController<bool> _lifeLost = StreamController();

  FinderLifePresenter({this.lifeConfigurationStream}){
    lifeConfigurationStream.listen(listenLifeConfiguration);
    _summary = FinderSumaryScore();
  }
  
  FinderLifesView get view => _view;
  set setView(FinderLifesView vw){
    _view = vw;
  }
  int get life => _summary.life ?? 0;

  StreamSink<bool> get lifeLostSink => _lifeLost.sink;
  Stream<bool> get lifeLostStream => _lifeLost.stream;

  listenLifeConfiguration(int val){
    print("losting life");
    if(val < 0){
      lifeLostSink.add(true);
    }else{
      SoundManager.manager.play(
        player: FindPairsApp.of(view.currentContext()).presenter.particleSound,
        filename: "awww.mp3",
      );
      _summary.setLife = val;
      view.notifyState();
    }
  }

  @override
  void initiateData() async{
    super.initiateData();
    await _summary.getLifeFromStore();
    view.notifyState();
  }

  void dispose(){
    _lifeLost.close();
  }
}