import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/StackedCardsView.dart';
import 'package:findpairs/Presenters/Components/Cards/StackedCardsPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/StackedCardItem.dart';
import 'package:flutter/material.dart';

class StackedCards extends StatefulWidget {
  final StreamSink<List<int>> stackedSink;
  final Stream<List<int>> boardCardStream;
  final Stream<int> cardPaired;
  final Key stackedItemKey;

  StackedCards({@required this.stackedSink, @required this.cardPaired, @required this.boardCardStream, @required this.stackedItemKey});

  @override
  _StackedCardsState createState() => new _StackedCardsState();
}

class _StackedCardsState extends State<StackedCards> with StackedCardsView{

  StackedCardsPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = StackedCardsPresenter(
      stackedSinker: widget.stackedSink,
      cardPaired: widget.cardPaired,
      boardCardStream: widget.boardCardStream
    )
    ..setView = this
    ..initiateData();
  }
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        children: presenter.stackedCards.map((val){
          int index = presenter.stackedCards.indexOf(val);
          double top = (2 * index).toDouble();
          double side = 8 - (2 * index).toDouble();
          GlobalKey key = GlobalKey();
          return Positioned(
            top: top,
            left: side,
            right: side,
            child: StackedCardItem(
              width: cardWidth - top,
              height: cardHeight - top,
              destroyStream: presenter.destroyCardStream,
              refillSink: presenter.refillCardSink,
              value: val,
              key: index != presenter.stackedCards.length - 1 ? key : widget.stackedItemKey,
            ),
          );
        }).toList()
      ),
    );
  }

  @override
  BuildContext currentContext() {
    return context;
  }

  @override
  void notifyState() {
    super.notifyState();
    if(mounted){
      setState(() {
        
      });
    }
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }
}