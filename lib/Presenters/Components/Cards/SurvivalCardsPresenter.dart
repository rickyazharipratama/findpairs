import 'dart:async';

import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/PresenterViews/Components/Cards/SurvivalCardsView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:findpairs/Utils/SoundManager.dart';

class SurvivalCardsPresenter extends BaseComponentPresenter{

  final Stream<int> clearDragCardStream;
  final StreamSink<int> finderValueSink;
  final Stream<bool> restartGameStream;
  SurvivalCardsView _view;
  List<int> _queues;
  StreamController<bool> _finishingAnimController = StreamController();

  SurvivalCardsPresenter({this.clearDragCardStream, this.finderValueSink, this.restartGameStream}){
    clearDragCardStream.listen(listenClearDragStream);
    restartGameStream.listen(restartListener);
    finishingAnimStream.listen(listenfinishingAnimation);
  }

  List<int> get queues => _queues;

  StreamController<bool> _shouldAnimatedController = StreamController.broadcast();

  SurvivalCardsView get view => _view;
  set setView(SurvivalCardsView vw){
    _view = vw;
  }

  StreamSink<bool> get shouldAnimatedSink => _shouldAnimatedController.sink;
  Stream<bool> get shouldAnimatedStream => _shouldAnimatedController.stream;

  StreamSink<bool> get finishingAnimSink => _finishingAnimController.sink;
  Stream<bool> get finishingAnimStream => _finishingAnimController.stream;

  @override
  initiateData(){
    super.initiateData();
    Future.delayed(
      const Duration(milliseconds: 300),
      () async{
        if(await view.prepareToPlay()){
          restartListener(true);
        }
      }
    );
  }

  restartListener(bool isVal){
    if(isVal){
      initializingCard();
      view.notifyState();
    }
  }

  initializingCard(){
    if(_queues == null){
      _queues = List();
    }else{
      _queues.clear();
    }

    for(int i = 0; i < 6; i++){
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

  void listenfinishingAnimation(bool isVal){
    print("finishing animation");
    view.notifyState();
  }

  updatingCard(){
    print("updating card list");
    shouldAnimatedSink.add(true);
    SoundManager.manager.play(
      player: FindPairsApp.of(view.currentContext()).presenter.particleSound,
      filename: "card_flip.mp3"
    );
    int unique = CommonUtil.instance.getUniqueRandom(
      max: 32,
      reference: queues
    );
    queues.insert(0, unique);
    queues.removeLast();
    finderValueSink.add(queues.last);
  }

  dispose(){
    _shouldAnimatedController.close();
    _finishingAnimController.close();
  }
}