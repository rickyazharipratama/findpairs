import 'dart:async';

import 'package:findpairs/Models/SurvivalScore.dart';
import 'package:findpairs/PresenterViews/Components/misc/SurvivalScoreWrapperView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class SurvivalScoreWrapperPresenter extends BaseComponentPresenter{

  final Stream<bool> cardPairedStream;
  final StreamSink<SurvivalScore> reportScoreSink;
  final Stream<bool> restartStream;

  SurvivalScoreWrapperView _view;
  SurvivalScore _score;

  SurvivalScoreWrapperView get view => _view;
  set setView(SurvivalScoreWrapperView vw){
    _view = vw;
  }

  SurvivalScore get score => _score;
  set setScore(SurvivalScore sc){
    _score = sc;
  }

  SurvivalScoreWrapperPresenter({this.cardPairedStream, this.reportScoreSink, this.restartStream}){
    _score = SurvivalScore();
    cardPairedStream.listen(listenCardPaired);
    restartStream.listen(listenRestartGame);
  }

  @override
  void initiateData() async{
    super.initiateData();
  }

  listenRestartGame(bool val){
    _score = SurvivalScore();
    view.notifyState();
  }

  listenCardPaired(bool val){
    if(val){
      score.increaseScore = 3;
      view.notifyState();
    }else{
      reportScoreSink.add(score);
    }
  }
}