import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/SurvivalCardsView.dart';
import 'package:findpairs/Presenters/Components/Cards/SurvivalCardsPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/DragableCard.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/SurvivalFrontCard.dart';
import 'package:flutter/material.dart';

class SurvivalCards extends StatefulWidget {

  final double cardWidth;
  final double cardHeight;
  final Stream<int> clearDataTargetStream;
  final StreamSink<int> finderValueSink;
  final Stream<bool> restartStream;

  SurvivalCards({@required this.cardWidth, @required this.cardHeight, @required this.clearDataTargetStream, @required this.finderValueSink, @required this.restartStream});

  @override
  _SurvivalCardsState createState() => new _SurvivalCardsState();
}

class _SurvivalCardsState extends State<SurvivalCards> with SurvivalCardsView{

  SurvivalCardsPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = SurvivalCardsPresenter(
      clearDragCardStream: widget.clearDataTargetStream,
      finderValueSink: widget.finderValueSink,
      restartGameStream: widget.restartStream
    )
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10)
        )
      ),
      width: widget.cardWidth + 20,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5 + MediaQuery.of(context).padding.bottom),
      child: Stack(
        children: List.generate(presenter.queues == null ? 0 : presenter.queues.length, (index){
          double bottom = ((index == 0 ? 5 : 10) + widget.cardHeight) * index;
          int idx = presenter.queues.length - 1 - index;
          return index == 0 ? Positioned(
            bottom: bottom,
            left: 0,
            child: 
              DragableCard(
                cardHeight: widget.cardHeight,
                cardWidth: widget.cardWidth,
                draggedCallback: (){},
                val: presenter.queues[idx],
              )
            
          ) : SurvivalFrontCard(
                cardHeight: widget.cardHeight,
                cardWidth: widget.cardWidth,
                val: presenter.queues[idx],
                shouldAnimateStream: presenter.shouldAnimatedStream,
                bottom: bottom,
                finishAnimateSink: presenter.finishingAnimSink,
            );
        }).toList()
      )
    );
  }

  @override
  BuildContext currentContext() => context;

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