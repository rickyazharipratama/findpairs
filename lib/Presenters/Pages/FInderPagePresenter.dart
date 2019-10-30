import 'dart:async';

import 'package:findpairs/PresenterViews/Pages/FInderPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';

class FinderPagePresenter extends BasePagePresenter{

  FinderPageView _view;
  StreamController<GamePauseType> _pauseController = StreamController();
  StreamController<int> _increaseScoreController = StreamController();
  StreamController<int> _reduceScoreController = StreamController();

  FinderPageView get view => _view;
  set setView(FinderPageView vw){
    _view = vw;
  }

  StreamSink<GamePauseType> get pauseSink => _pauseController.sink;
  Stream<GamePauseType> get pauseStream => _pauseController.stream;

  StreamSink<int> get increaseScoreSink => _increaseScoreController.sink;
  Stream<int> get increaseScoreStream => _increaseScoreController.stream;

  StreamSink<int> get reduceScoreSink => _reduceScoreController.sink;
  Stream<int> get reduceScoreStream => _reduceScoreController.stream;

  @override
  void initiateData() {
    super.initiateData();
  }

  void dispose(){
    _pauseController.close();
    _increaseScoreController.close();
    _reduceScoreController.close();
  }
}