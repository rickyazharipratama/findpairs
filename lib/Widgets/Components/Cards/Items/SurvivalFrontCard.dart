import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/Items/SurvivalFrontCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/Item/SurvivalFrontCardPresenter.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:flutter/material.dart';

class SurvivalFrontCard extends StatefulWidget {

  final double cardWidth;
  final double cardHeight;
  final double bottom;
  final int val;
  final Stream<bool> shouldAnimateStream;
  final StreamSink<bool> finishAnimateSink;

  SurvivalFrontCard({@required this.cardWidth, @required this.cardHeight, @required this.bottom, @required this.val, @required this.shouldAnimateStream, @required this.finishAnimateSink});

  @override
  _SurvivalFrontCardState createState() => new _SurvivalFrontCardState();
}

class _SurvivalFrontCardState extends State<SurvivalFrontCard> with SingleTickerProviderStateMixin,SurvivalFrontCardView{

  SurvivalFrontCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = SurvivalFrontCardPresenter(
      value: widget.val,
      shouldAnimatedStream: widget.shouldAnimateStream,
      finishAnimSink: widget.finishAnimateSink
    )
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: anim.value,
      child : Container(
        width: widget.cardWidth,
        height: widget.cardHeight,
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular((widget.cardWidth / 100)*10),
        ),
        child: Center(
          child: Image.asset(
            ConstantCollections.cards["Episode-01"][widget.val],
            width: (widget.cardWidth * 3) / 4,
            fit: BoxFit.fitWidth,
          )
        ),
      )
    );
  }

  @override
  double getBottom() {
    return widget.bottom;
  }

  @override
  double getCardHeight() {
    return widget.cardHeight;
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