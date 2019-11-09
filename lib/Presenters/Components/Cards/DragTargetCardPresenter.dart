import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/DragTargetCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class DragTargetCardPresenter extends BaseComponentPresenter{

  DragTargetCardView _view;
  int _targetVal = -1;
  bool _isDragRestricted = false;
  final Stream<bool> dragRestrictedStream;
  final Stream<int> clearDragTargetStream;
  final StreamSink<Map<String,int>> dragTargetSink;
  final Stream<bool> restartStream;
  final int position;

  DragTargetCardPresenter({this.dragRestrictedStream, this.clearDragTargetStream, this.dragTargetSink, this.position, this.restartStream}){
    dragRestrictedStream.listen(listenDragRestrict);
    clearDragTargetStream.listen(resetTargetVal);
    restartStream.listen(listenRestart);
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

  void listenRestart(bool isVal){
    if(isVal){
      resetTargetVal(-1);
    }
  }

  updatingTargetVal(int val){
    setTargetVal = val;
    dragTargetSink.add({
      "position":position,
      "value":val
    });
    view.notifyState();
  }

  resetTargetVal(int val){
    setTargetVal = -1;
    view.notifyState();
  }
}