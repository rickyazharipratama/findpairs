import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Text/FInderCorrectRatioTextView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class FinderCorrectRatioTextPresenter extends BaseComponentPresenter{

  FinderCorrectRatioTextView _view;
  FinderSumaryScore _summary;

  FinderCorrectRatioTextPresenter(){
    _summary = FinderSumaryScore();
  }

  FinderCorrectRatioTextView get view => _view;
  set setView(FinderCorrectRatioTextView vw){
    _view = vw;
  }

  double get ratio => _summary.ratio;
  set setRatio(double val){
    _summary.setRatio = val;
  }

  @override
  void initiateData() {
    super.initiateData();
    _summary.getRatioFromStore();
  }
}