import 'package:findpairs/PresenterViews/Pages/SurvivalPageView.dart';
import 'package:findpairs/Presenters/Pages/SurvivalPagePresenter.dart';
import 'package:findpairs/Widgets/Components/Buttons/PauseActionButton.dart';
import 'package:findpairs/Widgets/Components/Cards/SurvivalBottomPlaced.dart';
import 'package:findpairs/Widgets/Components/Cards/SurvivalCardRace.dart';
import 'package:findpairs/Widgets/Components/Cards/SurvivalCards.dart';
import 'package:findpairs/Widgets/Components/misc/SurvivalScoreWrapper.dart';
import 'package:findpairs/Widgets/Pages/WrapperPage.dart';
import 'package:flutter/material.dart';

class SurvivalPage extends StatefulWidget {

  final bool isFirstPlay;

  SurvivalPage({this.isFirstPlay : false});

  @override
  _SurvivalPageState createState() => new _SurvivalPageState();
}

class _SurvivalPageState extends State<SurvivalPage> with SurvivalPageView{

  SurvivalPagePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = SurvivalPagePresenter()
    ..setView = this
    ..initiateData();
  }
  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      leftHeader: Text(
        "Matcher",
        style: Theme.of(context).textTheme.display1.apply(
          color: Colors.white
        ),
      ),
      actions: <Widget>[
        PauseActionButton(
          sinker: presenter.pauseSink,
        )
      ],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          
          Expanded(
            child: Stack(
              children: <Widget>[

                Positioned.fill(
                  child: SurvivalCardRace(
                    finderFrontCardKey: finderFrontCardKey,
                    height: cardSize.height,
                    width: cardSize.width,
                    dragRestrictedSink: presenter.dragTargetRestrictedSink,
                    clearDragTargetSink: presenter.clearDragTargetSink,
                    finderValueStream: presenter.finderCardValueStream,
                    fasterRaceStream: presenter.fasterRaceStream,
                    dragTargetStream: presenter.dragTargetStream,
                    isCardCorrectSink: presenter.isCardCorrectSink,
                    pauseStream: presenter.pauseStream,
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SurvivalBottomPlaced(
                    dragTargetCardKey: dragTargetCardKey,
                    cardHeight: cardSize.height,
                    cardWidth: cardSize.width,
                    dragRestrictStream: presenter.dragTargetRestrictedStream,
                    clearDragTargetStream: presenter.clearDragTargetStream,
                    fasterRaceSink: presenter.fasterRaceSink,
                    dragTargetSink: presenter.dragTargetSink,
                    isCardCorrectStream: presenter.isCardCorrectStream,
                    restartStream: presenter.restartGameStream,
                  ),
                )
              ],
            )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              
              SurvivalScoreWrapper(
                key: survivalScoreWrapperKey,
                cardPairedStream: presenter.isCardCorrectStream,
                reportScoreSink: presenter.reportScoreSink,
                restartGameStream: presenter.restartGameStream,
              ),

              Expanded(
                child: SurvivalCards(
                  daragableCardKey: dragableCardKey,
                  cardWidth: cardSize.width,
                  cardHeight: cardSize.height,
                  clearDataTargetStream: presenter.clearDragTargetStream,
                  finderValueSink: presenter.finderCardValueSink,
                  restartStream: presenter.restartGameStream,
                )
              )
            ],
          )
        ],
      )
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