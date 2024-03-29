import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Text/FinderScoreTextView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';

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
  initiateData() async{
    await _summaryScore.getScoreFromStore();
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

  onListenStreamScore(int val) async{
    _summaryScore.setScore = _summaryScore.score + val;
    await _summaryScore.setScoreToStore();
    CommonUtil.instance.showLog(log:"increasing score to :" + totalScore.toString()+"from incoming val : "+val.toString());
    view.notifyState();
  }

  onListenStreamReduce(int val) async{
    _summaryScore.setScore = _summaryScore.score - val;
    await _summaryScore.setScoreToStore();
    view.notifyState();
  }
}