import 'package:findpairs/PresenterViews/Pages/StagesPageView.dart';
import 'package:findpairs/Presenters/Pages/StagesPagePresenter.dart';
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

class _StagesPageState extends State<StagesPage> with StagesPageView{

  StagesPagePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = StagesPagePresenter(
      episode: widget.episode,
      stage: widget.stage
    )..setView = this..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      leftHeader: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          "Stage "+presenter.stage.toString(),
          style: Theme.of(context).textTheme.display1.apply(
            color: Colors.white
          ),
        ),
      ),
      actions: <Widget>[
        PauseActionButton(
          sinker: presenter.pauseSink,
        )
      ],
      child: ArcadeCard(
        pauseSink: presenter.pauseSink,
        episode: widget.episode,
        stage: widget.stage,
        episodeSinker: presenter.episodeSink,
        stageSinker: presenter.stageSink,
        pauseStream: presenter.pauseStream,
      )
    );
  }

  @override
  notifyState() {
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