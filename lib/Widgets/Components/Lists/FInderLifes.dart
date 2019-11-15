import 'package:findpairs/PresenterViews/Components/Lists/FinderLifesView.dart';
import 'package:findpairs/Presenters/Components/Lists/FinderLifePresenter.dart';
import 'package:findpairs/Widgets/Components/Lists/ArcadeLifes.dart';
import 'package:flutter/material.dart';

class FinderLifes extends StatefulWidget {

  final Stream<int> lifeConfigurationStream;

  FinderLifes({@required this.lifeConfigurationStream, @required Key key}):super(key: key);

  @override
  _FinderLifesState createState() => new _FinderLifesState();
}

class _FinderLifesState extends State<FinderLifes> with FinderLifesView{

  FinderLifePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FinderLifePresenter(
      lifeConfigurationStream: widget.lifeConfigurationStream
    )
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return ArcadeLifes(
      stream: presenter.lifeLostStream,
      lifes: presenter.life,
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