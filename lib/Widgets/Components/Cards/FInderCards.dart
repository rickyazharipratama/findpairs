import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/FinderCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/FinderCardPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FInderFlipCard.dart';
import 'package:flutter/material.dart';

class FinderCards extends StatefulWidget {

  final Stream<List<int>> stackedStream;
  final StreamSink<List<int>> boardCardSink;

  FinderCards({@required this.stackedStream, @required this.boardCardSink});

  @override
  _FinderCardsState createState() => new _FinderCardsState();
}

class _FinderCardsState extends State<FinderCards> with FinderCardView{

  FinderCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FinderCardPresenter(
      stackedCardStream: widget.stackedStream,
      boardCardSink: widget.boardCardSink
    )
    ..setView = this;
  }

  @override
  Widget build(BuildContext context) {
    return presenter.boardCards == null ?
      Container()
    : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(presenter.finderAssets.currentCardFormation.vertical, (idx){
          return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(presenter.finderAssets.currentCardFormation.horizontal, (index){
                int skiprow = 0;
                if(idx > 0){
                  for(int i=0; i < idx;i++){
                    skiprow+= presenter.finderAssets.currentCardFormation.formations[i];
                  }
                }
                print("skipRows : "+skiprow.toString());
                print("index : "+(skiprow + index).toString());
                return FinderFlipCard(
                  width: cardSize.width,
                  height: cardSize.height,
                  value: presenter.boardCards[skiprow+index],
                );
              }),
            );
        }).toList(),
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
}