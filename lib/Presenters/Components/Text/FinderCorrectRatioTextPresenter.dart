import 'package:findpairs/PresenterViews/Components/Text/FInderCorrectRatioTextView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';

class FinderCorrectRatioTextPresenter extends BaseComponentPresenter{

  FinderCorrectRatioTextView _view;
  final Stream<double> updateRatio;
  double _ratio = 1.0;

  FinderCorrectRatioTextPresenter({this.updateRatio}){
   updateRatio.listen(listenUpdateRatio);
  }

  double get ratio => _ratio;
  set setRatio(double val){
    _ratio = val;
  }

  FinderCorrectRatioTextView get view => _view;
  set setView(FinderCorrectRatioTextView vw){
    _view = vw;
  }

  listenUpdateRatio(double val){
    CommonUtil.instance.showLog(log:"incoming ratio : "+val.toString());
    setRatio = val;
    view.notifyState();
  }
}