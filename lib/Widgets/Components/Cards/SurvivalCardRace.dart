import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/SurvivalCardRaceView.dart';
import 'package:findpairs/Presenters/Components/Cards/SurvivalCardRacePresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FinderFrontCard.dart';
import 'package:flutter/material.dart';

class SurvivalCardRace extends StatefulWidget {

  final double width;
  final double height;
  final StreamSink<bool> dragRestrictedSink;
  final StreamSink<int> clearDragTargetSink;
  final Stream<int> finderValueStream;
  final Stream<bool> fasterRaceStream;
  final Stream<Map<String,int>> dragTargetStream;
  final StreamSink<bool> isCardCorrectSink;
  final Stream<GamePauseType> pauseStream;
  final Key finderFrontCardKey;

  SurvivalCardRace({@required this.width, @required this.height, @required this.dragRestrictedSink, @required this.clearDragTargetSink, @required this.finderValueStream, @required this.fasterRaceStream, @required this.dragTargetStream, @required this.isCardCorrectSink, @required this.pauseStream, @required this.finderFrontCardKey});

  @override
  _SurvivalCardRaceState createState() => new _SurvivalCardRaceState();
}

class _SurvivalCardRaceState extends State<SurvivalCardRace> with TickerProviderStateMixin,SurvivalCardRaceView{

  SurvivalCardRacePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = SurvivalCardRacePresenter(
      cardHeight: widget.height,
      restrictDragTargetSink: widget.dragRestrictedSink,
      clearDragTargetSink: widget.clearDragTargetSink,
      finderValueStream: widget.finderValueStream,
      fasterRaceStream: widget.fasterRaceStream,
      dragTargetStream: widget.dragTargetStream,
      isCardCorrectSink: widget.isCardCorrectSink,
      pauseStream: widget.pauseStream
    )
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: firstCardAnimation == null ? -widget.height : firstCardAnimation.value,
          left: 10,
          child: FinderFrontCard(
            height: widget.height,
            width: widget.width,
            val: presenter.cardRaces == null ? 0 : presenter.cardRaces[0],
          )
        ),

        Positioned(
          top: secondCardAnimation == null ? -widget.height : secondCardAnimation.value,
          left: (widget.width + 20),
          child: FinderFrontCard(
            key: widget.finderFrontCardKey,
            height: widget.height,
            width: widget.width,
            val: presenter.cardRaces == null ? 0 : presenter.cardRaces[1],
          )
        ),

        Positioned(
          top: thirdCardAnimation == null ? -widget.height : thirdCardAnimation.value,
          left: ((widget.width * 2) + 30),
          child: FinderFrontCard(
            height: widget.height,
            width: widget.width,
            val: presenter.cardRaces == null ? 0 : presenter.cardRaces[2],
          )
        )
      ],
    );
  }

  @override
  double getCardHeight() => widget.height;

  @override
  double getCardWidth() => widget.width;

  @override
  TickerProvider currentTicker() => this;
  
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
  dispose(){
    presenter.dispose();
    super.dispose();
  }

}