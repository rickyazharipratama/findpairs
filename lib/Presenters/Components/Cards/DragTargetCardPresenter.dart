import 'package:findpairs/PresenterViews/Components/Cards/DragTargetCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class DragTargetCardPresenter extends BaseComponentPresenter{

  DragTargetCardView _view;
  int _targetVal = -1;

  DragTargetCardView get view => _view;
  set setView(DragTargetCardView vw){
    _view = vw;
  }

  int get targetVal => _targetVal;
  set setTargetVal(int val){
    _targetVal = val;
  }

  updatingTargetVal(int val){
    setTargetVal = val;
    view.notifyState();
  }

  resetTargetVal(int val){
    setTargetVal = -1;
    view.notifyState();
  }

}