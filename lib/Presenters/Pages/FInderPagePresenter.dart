import 'dart:async';

import 'package:findpairs/PresenterViews/Pages/FInderPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';

class FinderPagePresenter extends BasePagePresenter{

  FinderPageView _view;
  StreamController<GamePauseType> _pauseController = StreamController();
  StreamController<int> _increaseScoreController = StreamController();
  StreamController<int> _reduceScoreController = StreamController();
  StreamController<List<int>> _stackedCardController = StreamController();
  StreamController<List<int>> _boardCardController = StreamController();
  StreamController<int> _cardPairedController = StreamController();
  StreamController<double> _ratioUpdatingController = StreamController();

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

  StreamSink<List<int>> get stackedCardSink => _stackedCardController.sink;
  Stream<List<int>> get stackedCardStream => _stackedCardController.stream;

  StreamSink<int> get cardPairedSink => _cardPairedController.sink;
  Stream<int> get cardPairedStream => _cardPairedController.stream;

  StreamSink<List<int>> get boardCardSink => _boardCardController.sink;
  Stream<List<int>> get boardCardStream => _boardCardController.stream; 

  StreamSink<double> get ratioUpdateSink => _ratioUpdatingController.sink;
  Stream<double> get ratioUpdateStream => _ratioUpdatingController.stream;

  @override
  void initiateData() {
    super.initiateData();
  }

  void dispose(){
    _pauseController.close();
    _increaseScoreController.close();
    _reduceScoreController.close();
    _stackedCardController.close();
    _cardPairedController.close();
    _boardCardController.close();
    _ratioUpdatingController.close();
  }
}