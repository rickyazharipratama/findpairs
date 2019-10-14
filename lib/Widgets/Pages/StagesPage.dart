import 'package:findpairs/Widgets/Components/Buttons/SettingActionButton.dart';
import 'package:findpairs/Widgets/Components/Cards/ArcadeCards.dart';
import 'package:findpairs/Widgets/Pages/WrapperPage.dart';
import 'package:flutter/material.dart';

class StagesPage extends StatefulWidget {
  final int stage;
  final String episode;

  StagesPage({@required this.stage, @required this.episode});

  @override
  _StagesPageState createState() => new _StagesPageState();
}

class _StagesPageState extends State<StagesPage> {

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      leftHeader: Text(
        "Stage "+ widget.stage.toString(),
      ),
      actions: <Widget>[
        SettingActionButton()
      ],
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
          ),

          Expanded(
            child: ArcadeCard(
              stage: widget.stage,
              episode: widget.episode,
            ),
          ),

          Container(
            height: 100,
          )
        ],
      ),
    );
  }
}