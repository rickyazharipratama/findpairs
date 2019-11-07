import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/SurvivalCardsView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';

class SurvivalCardsPresenter extends BaseComponentPresenter{

  final Stream<int> clearDragCardStream;
  final StreamSink<int> finderValueSink;
  SurvivalCardsView _view;
  List<int> _queues;

  SurvivalCardsPresenter({this.clearDragCardStream, this.finderValueSink}){
    clearDragCardStream.listen(listenClearDragStream);
  }

  List<int> get queues => _queues;

  StreamController<bool> _shouldAnimatedController = StreamController.broadcast();

  SurvivalCardsView get view => _view;
  set setView(SurvivalCardsView vw){
    _view = vw;
  }

  StreamSink<bool> get shouldAnimatedSink => _shouldAnimatedController.sink;
  Stream<bool> get shouldAnimatedStream => _shouldAnimatedController.stream;

  @override
  initiateData(){
    super.initiateData();
    initializingCard();
    view.notifyState();
  }

  initializingCard(){
    if(_queues == null){
      _queues = List();
    }else{
      _queues.clear();
    }

    for(int i = 0; i < 4; i++){
      int unique = CommonUtil.instance.getUniqueRandom(
        max: 32,
        reference: _queues
      );
      _queues.add(unique);
    }
    finderValueSink.add(_queues.last);
  }

  void listenClearDragStream(int val){
    updatingCard();
  }

  updatingCard(){
    print("updating card list");
    shouldAnimatedSink.add(true);
    queues.removeLast();
    int unique = CommonUtil.instance.getUniqueRandom(
      max: 32,
      reference: queues
    );
    queues.insert(0, unique);
    finderValueSink.add(queues.last);
    Future.delayed(
      const Duration(milliseconds: 250),
      view.notifyState
    );
  }

  dispose(){
    _shouldAnimatedController.close();
  }
}