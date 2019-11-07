import 'package:findpairs/PresenterViews/Components/Cards/DragTargetCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class DragTargetCardPresenter extends BaseComponentPresenter{

  DragTargetCardView _view;
  int _targetVal = -1;
  bool _isDragRestricted = false;
  final Stream<bool> dragRestrictedStream;
  final Stream<int> clearDragTargetStream;

  DragTargetCardPresenter({this.dragRestrictedStream, this.clearDragTargetStream}){
    dragRestrictedStream.listen(listenDragRestrict);
    clearDragTargetStream.listen(resetTargetVal);
  }

  DragTargetCardView get view => _view;
  set setView(DragTargetCardView vw){
    _view = vw;
  }

  set setDragRestricted(bool val){
    _isDragRestricted = val;
  }
  bool get isDragRestricted => _isDragRestricted;

  int get targetVal => _targetVal;
  set setTargetVal(int val){
    _targetVal = val;
  }

  void listenDragRestrict(bool val){
    _isDragRestricted = val;
    view.notifyState();
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