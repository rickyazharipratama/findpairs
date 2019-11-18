import 'dart:async';

import 'package:findpairs/PresenterViews/Pages/FInderPageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinderPagePresenter extends BasePagePresenter{

  FinderPageView _view;
  StreamController<GamePauseType> _pauseController = StreamController();
  StreamController<int> _increaseScoreController = StreamController();
  StreamController<int> _reduceScoreController = StreamController();
  StreamController<List<int>> _stackedCardController = StreamController();
  StreamController<List<int>> _boardCardController = StreamController();
  StreamController<int> _cardPairedController = StreamController();
  StreamController<double> _ratioUpdatingController = StreamController();
  StreamController<int> _lifeConfigurationController = StreamController();
  GamePauseType pauseType = GamePauseType.onGameresume;

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

  StreamSink<int> get lifeConfigurationSink => _lifeConfigurationController.sink;
  Stream<int> get lifeConfigurationStream => _lifeConfigurationController.stream;

  @override
  void initiateData() {
    super.initiateData();
    pauseStream.listen(pauseStreamListen);
    showTutorial();
  }

  void pauseStreamListen(GamePauseType type){
    pauseType = type;
    if(type == GamePauseType.onGameExit){
      view.closePage();
    }
  }

  showTutorial() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isALreadyShowTutorial = pref.getBool(ConstantCollections.PREF_FINDER_TUTORIAL);
    if(isALreadyShowTutorial == null || !isALreadyShowTutorial){
      Future.delayed(
        const Duration(milliseconds: 700),
        (){
          if(pauseType == GamePauseType.onGameresume){
            //show Tutorial
            pauseSink.add(GamePauseType.onGamePause);
            view.showTutorial(finishTutorial);
          }
        }
      );
    }
  }

  finishTutorial() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(ConstantCollections.PREF_FINDER_TUTORIAL, true);
    if(pauseType == GamePauseType.onGamePause){
      pauseSink.add(GamePauseType.onGameresume);
    }
  }

  void dispose(){
    _pauseController.close();
    _increaseScoreController.close();
    _reduceScoreController.close();
    _stackedCardController.close();
    _cardPairedController.close();
    _boardCardController.close();
    _ratioUpdatingController.close();
    _lifeConfigurationController.close();
  }
}