import 'package:findpairs/PresenterViews/FindPairsAppPresenterView.dart';
import 'package:findpairs/Presenters/FindPairsAppPresenter.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:findpairs/Utils/FindPairsTheme.dart';
import 'package:findpairs/Widgets/Pages/LandingPage.dart';
import 'package:flutter/material.dart';

class FindPairsApp extends StatefulWidget {
  @override
  _FindPairsAppState createState() => new _FindPairsAppState();

  static _FindPairsAppState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<_FindPairsAppState>());

}

class _FindPairsAppState extends State<FindPairsApp> with FindPairsAppPresenterView{
  
  FindPairsAppPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FindPairsAppPresenter()..setView = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstantCollections.APPNAME,
      theme: FindPairsTheme.instance.lightFindPairsTheme,
      home: LandingPage(),
    );
  }
}