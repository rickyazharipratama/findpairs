import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/SurvivalCardsView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';

class SurvivalCardsPresenter extends BaseComponentPresenter{

  SurvivalCardsView _view;
  List<int> _queues;
  List<String> _queueKeys;


  List<int> get queues => _queues;
  List<String> get queueKeys => _queueKeys;

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

    if(_queueKeys == null){
      _queueKeys = List();
    }else{
      _queueKeys.clear();
    }

    for(int i = 0; i < 4; i++){
      int unique = CommonUtil.instance.getUniqueRandom(
        max: 32,
        reference: _queues
      );
      _queues.add(unique);
      _queueKeys.add(DateTime.now().millisecondsSinceEpoch.toString()+unique.toString());
    }
  }

  updatingCard(){
    print("updating card list");
    shouldAnimatedSink.add(true);
    queueKeys.removeLast();
    queues.removeLast();
    int unique = CommonUtil.instance.getUniqueRandom(
      max: 32,
      reference: queues
    );
    queues.insert(0, unique);
    queueKeys.insert(0, DateTime.now().millisecondsSinceEpoch.toString() + unique.toString());
    Future.delayed(
      const Duration(milliseconds: 250),
      view.notifyState
    );
  }



  dispose(){
    _shouldAnimatedController.close();
  }
}