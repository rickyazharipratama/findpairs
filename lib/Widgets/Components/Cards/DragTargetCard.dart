import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/DragTargetCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/DragTargetCardPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/DottedCard.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FinderFrontCard.dart';
import 'package:flutter/material.dart';

class DragTargetCard extends StatefulWidget {

  final double height;
  final double width;
  final Stream<bool> dragRestrictStream;
  final Stream<int> clearDragtargetStream;
  final StreamSink<bool> fasterRaceSink;
  final int position;
  final StreamSink<Map<String,int>> dragTargetSink;
  final Stream<bool> restartStream;

  DragTargetCard({@required this.height, @required this.width, @required this.dragRestrictStream, @required this.clearDragtargetStream, @required this.fasterRaceSink, @required this.position, @required this.dragTargetSink, @required this.restartStream});
  @override
  _DragTargetCardState createState() => new _DragTargetCardState();
}

class _DragTargetCardState extends State<DragTargetCard> with DragTargetCardView{
  
  DragTargetCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = DragTargetCardPresenter(
      dragRestrictedStream: widget.dragRestrictStream,
      clearDragTargetStream: widget.clearDragtargetStream,
      dragTargetSink: widget.dragTargetSink,
      position: widget.position,
      restartStream: widget.restartStream
    )
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      builder: (context,_,__)=>
        presenter.targetVal >= 0 && presenter.targetVal <= 32?
        GestureDetector(
          onLongPressStart: (LongPressStartDetails details){
            widget.fasterRaceSink.add(true);
          },
          onLongPressEnd: (LongPressEndDetails details){
            widget.fasterRaceSink.add(false);
          },
          child : FinderFrontCard(
            height: widget.height,
            width: widget.width,
            val: presenter.targetVal,
          )
        )
        : DottedCard(
          cardHeight: widget.height,
          cardWidth: widget.width,
        ),
      
      onWillAccept: (val){
        return true;
      },
      onAccept: presenter.updatingTargetVal,
      onLeave: presenter.resetTargetVal,
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

}