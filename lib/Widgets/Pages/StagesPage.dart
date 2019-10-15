import 'package:findpairs/Widgets/Components/Buttons/PauseActionButton.dart';
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
      leftHeader: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          "Stage "+widget.stage.toString(),
          style: Theme.of(context).textTheme.display1,
        ),
      ),
      actions: <Widget>[
        PauseActionButton()
      ],
      child: ArcadeCard(
        episode: widget.episode,
        stage: widget.stage,
      )
    );
  }
}