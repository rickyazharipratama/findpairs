import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/CardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/material.dart';

class ArcadeCardPresenter extends BaseComponentPresenter{
  
  CardView _view ;
  StreamController<String> _flipBack = StreamController.broadcast();
  StreamController<String> _selectedCard = StreamController();
  List<String> _selectedCards = List();


  CardView get view => _view;
  set setView(CardView vw){
    _view = vw;
  }

  List<String> get selectedCards => _selectedCards;

  Stream<String> get flipBack => _flipBack.stream;
  StreamSink<String> get selectedCardSinker => _selectedCard.sink;

  @override
  void initiateData() {
    super.initiateData();
    _selectedCard.stream.listen(addSelectedCard);
  }
  
  addSelectedCard(String card) async{
    debugPrint("selected card = "+card);
    selectedCards.add(card);
    if(selectedCards.length == 2){
      if(isCardPaired()){
        //should animate becasue  card is paired
      }else{

        for( int i = 0; i < selectedCards.length; i++){
          await Future.delayed(Duration(milliseconds: 650 - (i * 150) > 100 ? 650 - (i * 150) : 100),(){
            flippingBackCard(selectedCards[i]);
            if(i+1 >= selectedCards.length){
              selectedCards.clear();
            }
          });
        }
      }
    }
  }

  bool isCardPaired(){
    if(selectedCards[0] == selectedCards[1]){
      return true;
    }
    return false;
  }

  // call it when not pairs
  void flippingBackCard(String val){
    _flipBack.add(val);
  }

  dispose(){
    _flipBack.close();
    _selectedCard.close();
  }
}