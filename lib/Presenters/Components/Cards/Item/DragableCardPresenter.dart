import 'package:findpairs/PresenterViews/Components/Cards/Items/DragableCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:flutter/foundation.dart';

class DragableCardPresenter extends BaseComponentPresenter{

  final VoidCallback draggedComplete;
  DragableCardView _view;
  bool _isDragAccepted = false;
  int _value = 0;

  DragableCardPresenter({this.draggedComplete, int val}){
    _value = val;
  }


  DragableCardView get view => _view;
  set setView(DragableCardView vw){
    _view = vw;
  }

  int get value => _value;
  set setValue(int val){
    _value = val;
  }

  bool get isDragAccepted => _isDragAccepted;

  void cardAlreadyAccepted(){
    CommonUtil.instance.showLog(log:"card already accepted");
    _isDragAccepted = true;
    view.notifyState();
    draggedComplete();
  }

  void resetDragAccepted({int val : 0}){
    CommonUtil.instance.showLog(log:"reseting card");
    _isDragAccepted = false;
    setValue = val;
    view.notifyState();
  }
}