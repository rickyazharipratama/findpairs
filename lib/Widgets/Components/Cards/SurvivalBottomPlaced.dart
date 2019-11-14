import 'dart:async';
import 'dart:ui';

import 'package:findpairs/PresenterViews/Components/Cards/SurvivalBottomPlacedView.dart';
import 'package:findpairs/Presenters/Components/Cards/SurvivalBottomPlacedPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/DragTargetCard.dart';
import 'package:flutter/material.dart';

class SurvivalBottomPlaced extends StatefulWidget {

  final double cardWidth;
  final double cardHeight;
  final Stream<bool> dragRestrictStream;
  final Stream<int> clearDragTargetStream;
  final StreamSink<bool> fasterRaceSink;
  final StreamSink<Map<String,int>> dragTargetSink;
  final Stream<bool> isCardCorrectStream;
  final Stream<bool> restartStream;
  final Key dragTargetCardKey;

  SurvivalBottomPlaced({@required this.cardWidth, @required this.cardHeight, @required this.dragRestrictStream, @required this.clearDragTargetStream, @required this.fasterRaceSink, @required this.dragTargetSink, @required this.isCardCorrectStream, @required this.restartStream, @required this.dragTargetCardKey});

  @override
  _SurvivalBottomPlacedState createState() => new _SurvivalBottomPlacedState();
}

class _SurvivalBottomPlacedState extends State<SurvivalBottomPlaced> with TickerProviderStateMixin,SurvivalBottomPlacedView{

  SurvivalBottomPlacedPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = SurvivalBottomPlacedPresenter(
      isCardCorrectStream: widget.isCardCorrectStream
    )
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8
        ),
        child: Container(
          height: wrapperHeight(widget.cardHeight),
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5 + MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: anim == null ? Color(0x55333333) : anim.value,
          ),
          child: Stack(
            children: <Widget>[

              Positioned(
                top: 0,
                left: 10,
                child: DragTargetCard(
                  dragRestrictStream: widget.dragRestrictStream,
                  height: widget.cardHeight,
                  width: widget.cardWidth,
                  clearDragtargetStream: widget.clearDragTargetStream,
                  fasterRaceSink: widget.fasterRaceSink,
                  position: 0,
                  dragTargetSink: widget.dragTargetSink,
                  restartStream: widget.restartStream,
                )
              ),

              Positioned(
                top: 0,
                left: (widget.cardWidth + 20),
                child: DragTargetCard(
                  key: widget.dragTargetCardKey,
                  dragRestrictStream: widget.dragRestrictStream,
                  height: widget.cardHeight,
                  width: widget.cardWidth,
                  clearDragtargetStream: widget.clearDragTargetStream,
                  fasterRaceSink: widget.fasterRaceSink,
                  position: 1,
                  dragTargetSink: widget.dragTargetSink,
                  restartStream: widget.restartStream,
                )
              ),

              Positioned(
                top: 0,
                left: ((widget.cardWidth * 2) + 30),
                child: DragTargetCard(
                  dragRestrictStream: widget.dragRestrictStream,
                  height: widget.cardHeight,
                  width: widget.cardWidth,
                  clearDragtargetStream: widget.clearDragTargetStream,
                  fasterRaceSink: widget.fasterRaceSink,
                  position: 2,
                  dragTargetSink: widget.dragTargetSink,
                  restartStream: widget.restartStream,
                )
              )
            ],
          ),
        ),
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
    super.dispose();
    presenter.dispose();
  }
}