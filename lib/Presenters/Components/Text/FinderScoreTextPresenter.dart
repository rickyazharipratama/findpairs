import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Text/FinderScoreTextView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class FinderScoreTextPresenter extends BaseComponentPresenter{

  FinderScoreTextView _view;

  final Stream<int> scoreStream;
  final Stream<int> reduceStream;

  FinderSumaryScore _summaryScore;

  FinderScoreTextPresenter(this.scoreStream, this.reduceStream){
    _summaryScore = FinderSumaryScore();
    scoreStream.listen(onListenStreamScore);
    reduceStream.listen(onListenStreamReduce);
  }

  @override
  initiateData(){
    _summaryScore.getScoreFromStore();
    view.notifyState();
  }
  
  FinderScoreTextView get view => _view;
  set setView(FinderScoreTextView vw){
    _view = vw;
  }

  int get totalScore => _summaryScore.score;
  set setTotalScore( int val){
    _summaryScore.setScore = val;
  }

  onListenStreamScore(int val){
    _summaryScore.setScore = _summaryScore.score + val;
    _summaryScore.setScoreToStore();
  }

  onListenStreamReduce(int val){
    _summaryScore.setScore = _summaryScore.score - val;
    _summaryScore.setScoreToStore();
  }
}