import 'dart:async';

import 'package:findpairs/Models/SurvivalScore.dart';
import 'package:findpairs/PresenterViews/Components/misc/SurvivalScoreWrapperView.dart';
import 'package:findpairs/Presenters/Components/misc/SurvivalScoreWrapperPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:findpairs/Widgets/Components/Text/VerticalFormText.dart';
import 'package:flutter/material.dart';

class SurvivalScoreWrapper extends StatefulWidget {

  final Stream<bool> cardPairedStream;
  final StreamSink<SurvivalScore> reportScoreSink;
  final Stream<bool> restartGameStream;

  SurvivalScoreWrapper({@required this.cardPairedStream, @required this.reportScoreSink, @required this.restartGameStream, Key key}):super(key : key);

  @override
  SurvivalScoreWrapperState createState() => SurvivalScoreWrapperState();
}

class SurvivalScoreWrapperState extends State<SurvivalScoreWrapper> with SurvivalScoreWrapperView{

  SurvivalScoreWrapperPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = SurvivalScoreWrapperPresenter(
      cardPairedStream: widget.cardPairedStream,
      reportScoreSink: widget.reportScoreSink,
      restartStream: widget.restartGameStream
    )
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
          child: VerticalFormText(
            label: "Score:",
            value: CommonUtil.instance.formatScore(presenter.score.score),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
          child: VerticalFormText(
            label: "Speed:",
            value: presenter.score.v.toString()+" px/s",
          ),
        )
      ],
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  void notifyState(){
    if(mounted){
      setState(() {
        
      });
    }
  }
}