import 'dart:async';

import 'package:findpairs/Models/ArcadeLogPlayer.dart';
import 'package:findpairs/PresenterViews/Pages/SelectArcadeStageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';

class SelectArcadeStagePresenter extends BasePagePresenter{

  SelectArcadeStageView _view;
  String _episode;
  ArcadeLogPlayer _log;

  StreamController<GamePauseType> _pauseController = StreamController();

  SelectArcadeStagePresenter(){
    pauseStream.listen(onPauseListen);
  }


  Stream<GamePauseType> get pauseStream => _pauseController.stream;
  StreamSink<GamePauseType> get pauseSink => _pauseController.sink;

  SelectArcadeStageView get view => _view;
  set setView(SelectArcadeStageView vw){
    _view = vw;
  }

  String get episode => _episode;
  set setEpisode(String ep){
    _episode = ep;
  }

  ArcadeLogPlayer get log => _log;

  onPauseListen(GamePauseType type){
    if(type == GamePauseType.onGameExit){
      view.closePage();
    }
  }

  @override
  void initiateData() async{
    super.initiateData();
    _log = ArcadeLogPlayer();
    await _log.retrieveData();
    view.notifyState();
  }

  dispose(){
    _pauseController.close();
  }
}