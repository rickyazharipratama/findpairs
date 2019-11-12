import 'dart:async';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xaa333333),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )
          ),
          width: widget.cardWidth + 20,
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5 + MediaQuery.of(context).padding.bottom),
          child: Stack(
            children:[

              Positioned(
                left: 5,
                right: 5,
                bottom: 0,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: Colors.white,
                  radius: Radius.circular(10),
                  strokeWidth: 2,
                  child: Center(
                    child: presenter.queues != null ? DragableCard(
                      cardHeight: widget.cardHeight,
                      cardWidth: widget.cardWidth,
                      draggedCallback: (){},
                      val: presenter.queues[presenter.queues.length -1],
                    ) : Container(
                      width: widget.cardWidth,
                      height: widget.cardHeight,
                    ),
                  )
                ),
              ),  

              Positioned.fill(
                left: 10,
                right: 5,
                top: 0,
                bottom: 0,
                child: Stack(
                  children: List.generate(presenter.queues != null ? presenter.queues.length - 1 : 0, (idx){
                    int index = (presenter.queues.length - 2) - idx;
                    double bottom = (widget.cardHeight * idx ) + (10 * idx) + (widget.cardHeight + 10);
                    return SurvivalFrontCard(
                        cardHeight: widget.cardHeight,
                        cardWidth: widget.cardWidth,
                        val: presenter.queues[index],
                        shouldAnimateStream: presenter.shouldAnimatedStream,
                        bottom: bottom,
                        finishAnimateSink: presenter.finishingAnimSink,
                    );
                  }).toList(),
                ),
              ),

              Positioned.fill(
                left: 0,
                right: 0,
                top: 0,
                bottom: (widget.cardHeight+10),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8,
                      sigmaY: 8
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xaa333333),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )
                      ),
                    ),
                  ),
                )
              )
            ]
          )
        ),
      ),
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