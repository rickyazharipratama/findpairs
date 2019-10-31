import 'dart:async';
import 'dart:math';

import 'package:findpairs/PresenterViews/Components/Cards/StackedCardsView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class StackedCardsPresenter extends BaseComponentPresenter{

  final StreamSink<List<int>> stackedSinker;
  final Stream<List<int>> boardCardStream;
  final Stream<int> cardPaired;
  StreamController<bool> _destroyCardController = StreamController<bool>.broadcast();
  StreamController<bool> _refillCardController = StreamController<bool>();
  StackedCardsView _view;
  List<int> _stackedCards;
  List<int> _boardCards;

  StackedCardsPresenter({this. stackedSinker, this.cardPaired, this.boardCardStream}){
    cardPaired.listen(onListenCardPaired);
    refillCardStream.listen(onListenRefillCard);
    boardCardStream.listen(onListenBoardCardStream);
  }

  StackedCardsView get view => _view;
  set setView(StackedCardsView vw){
    _view = vw;
  }

  List<int> get stackedCards => _stackedCards;
  List<int> get boardCards => _boardCards;

  StreamSink<bool> get destroyCardSink => _destroyCardController.sink;
  Stream<bool> get destroyCardStream => _destroyCardController.stream;

  StreamSink<bool> get refillCardSink => _refillCardController.sink;
  Stream<bool> get refillCardStream => _refillCardController.stream;

  @override
  void initiateData() {
    super.initiateData();
    configureStackedCards();
    view.notifyState();
  }

  configureStackedCards(){
    if(_stackedCards == null){
      _stackedCards = List();
    }else{
      _stackedCards.clear();
    }
    Random rand = Random();
    for(int i=0; i < 5; i++){
      int val = rand.nextInt(32);
      while(_stackedCards.contains(val)){
        val = rand.nextInt(32);
      }
      _stackedCards.add(val);
    }
    stackedSinker.add(_stackedCards);
  }

  onListenCardPaired(int val){
    //must remove last stacked card and insert into first stacked card
    stackedCards.removeLast();
    destroyCardSink.add(true);
  }

  onListenRefillCard(bool isval){
    if(isval){
      Random rand = Random();
      int nxt = rand.nextInt(32);
      while(stackedCards.contains(nxt)){
        nxt = rand.nextInt(32);
      }
       stackedCards.insert(0, nxt);
       stackedSinker.add(stackedCards);
    }
  }

  onListenBoardCardStream(List<int> boardCard){
    if(this._boardCards == null){
      this._boardCards = List();
    }else{
      this._boardCards.clear();
    }
    this._boardCards.addAll(boardCard);
  }

  void dispose(){
    _destroyCardController.close();
    _refillCardController.close();
  }
}