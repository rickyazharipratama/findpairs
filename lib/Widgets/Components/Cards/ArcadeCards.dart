import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/CardView.dart';
import 'package:findpairs/Presenters/Components/Cards/ArcadeCardPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FlipCard.dart';
import 'package:findpairs/Widgets/Components/Lists/ArcadeLifes.dart';
import 'package:findpairs/Widgets/Components/misc/ClockTimer.dart';
import 'package:flutter/material.dart';

class ArcadeCard extends StatefulWidget {
  final int stage;
  final String episode;
  final StreamSink<int> stageSinker;
  final StreamSink<String> episodeSinker;
  final Stream<GamePauseType> pauseStream;
  final StreamSink<GamePauseType> pauseSink;

  ArcadeCard({this.stage, this.episode, @required this.stageSinker, @required this.episodeSinker, @required this.pauseStream, @required this.pauseSink});
  
  @override
  _ArcadeCardState createState() => new _ArcadeCardState();
}

class _ArcadeCardState extends State<ArcadeCard> with CardView{

  ArcadeCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = ArcadeCardPresenter(widget.stage, widget.episode,widget.stageSinker, widget.episodeSinker, widget.pauseStream,
      pauseSink: widget.pauseSink
    )..setView = this
    ..initiateData();
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
                  List<GlobalKey> rows = List();
                  for(int i = 0; i  < formations.row; i++){
                    GlobalKey kk = GlobalKey();
                    if(presenter.setting.formations.last == formations){
                      if(i == formations.row -1){
                        rows.add(cardKey);
                      }else{
                        rows.add(kk);
                      }
                    }else{
                      rows.add(kk);
                    }
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: rows.map((row){
                      CommonUtil.instance.showLog(log:"screen width : "+MediaQuery.of(context).size.width.toString());
                      CommonUtil.instance.showLog(log:"card width : "+getCardWidth(presenter.setting.horizontal, presenter.setting.vertical).toString());
                      return FlipCard(
                        key: row,
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
            key: lifeKey,
            lifes: presenter.currentLife,
            stream: presenter.lifeStream,
          ) : Container(),
        ),

        // countedounw
        Positioned(
          top: 10,
          child: presenter.setting != null ? ClockTimer(
            key: timeKey,
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