import 'dart:async';

import 'package:findpairs/PresenterViews/Pages/StagesPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';

class StagesPagePresenter extends BasePagePresenter{

  StagesPageView _view;

  StreamController<int> _stagesController = StreamController();
  StreamController<String> _episodeController = StreamController();
  StreamController<GamePauseType> _pauseController = StreamController();
  


  StagesPagePresenter({int stage, String episode}){
    _stage = stage;
    _episode = episode;
  }

  @override
  initiateData(){
    stageStream.listen(onRetrieveStage);
    episodeStream.listen(onRetrieveEpisode);
  }

  int _stage;
  String _episode;

  StreamSink<int> get stageSink => _stagesController.sink;
  Stream<int> get stageStream => _stagesController.stream;

  StreamSink<String> get episodeSink => _episodeController.sink;
  Stream<String> get episodeStream => _episodeController.stream;

  StreamSink<GamePauseType> get pauseSink => _pauseController.sink;
  Stream<GamePauseType> get pauseStream => _pauseController.stream;

  

  set setView(StagesPageView vw){
    _view = vw;
  }
  StagesPageView get view => _view;

  set setStage(int val){
    _stage = val;
  }
  int get stage => _stage;

  set setEpisode(String val){
    _episode = val;
  }

  String get episode => _episode;

  onRetrieveStage(int stg){
    setStage = stg;
    view.notifyState();
  }

  onRetrieveEpisode(String ep){
    setEpisode = episode;
    view.notifyState();
  }

  void dispose(){
    _stagesController.close();
    _episodeController.close();
    _pauseController.close();
  }
}