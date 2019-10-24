import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/CardView.dart';
import 'package:findpairs/Presenters/Components/Cards/ArcadeCardPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FlipCard.dart';
import 'package:findpairs/Widgets/Components/Lists/ArcadeLifes.dart';
import 'package:findpairs/Widgets/Components/misc/ClockTimer.dart';
import 'package:flutter/material.dart';

class ArcadeCard extends StatefulWidget {
  final int stage;
  final String episode;
  final StreamSink<int> stageSinker;
  final StreamSink<String> episodeSinker;

  ArcadeCard({this.stage, this.episode, @required this.stageSinker, @required this.episodeSinker});
  
  @override
  _ArcadeCardState createState() => new _ArcadeCardState();
}

class _ArcadeCardState extends State<ArcadeCard> with CardView{

  ArcadeCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = ArcadeCardPresenter(widget.stage, widget.episode,widget.stageSinker, widget.episodeSinker)..setView = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 50,
          bottom: MediaQuery.of(context).padding.bottom,
          left: 0,
          right: 0,
          child: presenter.setting != null ? Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: presenter.setting.formations.map((formations){
                  List<int> rows = List();
                  for(int i = 0; i  < formations.row; i++){
                    rows.add(i);
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: rows.map((row){
                      print("screen width : "+MediaQuery.of(context).size.width.toString());
                      print("card width : "+getCardWidth(presenter.setting.horizontal, presenter.setting.vertical).toString());
                      return FlipCard(
                        width: getCardWidth(presenter.setting.horizontal, presenter.setting.vertical),
                        height: getCardHeight(getCardWidth(presenter.setting.horizontal, presenter.setting.vertical)),
                        restrictFlip: presenter.restrictFlip,
                        flipBack: presenter.flipBack,
                        streamCard: presenter.selectedCardSinker,
                        arcadeTime: presenter.arcadeTimerStream,
                        value: presenter.getAvailableCardValue(),
                        episode: presenter.episode,
                        paired: presenter.pairedStream,
                      );
                    }).toList(),
                  );
                }).toList()
              ),
            ),
          ) : Container(),
        ),

        Positioned(
          top: 10,
          right: 5,
          width: 130,
          height: 50,
          child: presenter.setting != null ? ArcadeLifes(
            lifes: presenter.currentLife,
            stream: presenter.lifeStream,
          ) : Container(),
        ),

        // countedounw
        Positioned(
          top: 10,
          child: presenter.setting != null ? ClockTimer(
            counter: presenter.setting.time,
            critTime: presenter.setting.critTime,
            sinker: presenter.arcadeTimerSinker,
            stream: presenter.arcadeTimerStream,
            timerSink: presenter.currentCD,
          ) : Container(),
        )
      ],
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  void notifyState() {
    super.notifyState();
    if(mounted){
      setState(() {});
    }
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }
}