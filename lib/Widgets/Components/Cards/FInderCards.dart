import 'package:findpairs/PresenterViews/Components/Cards/FinderCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/FinderCardPresenter.dart';
import 'package:flutter/material.dart';

class FinderCards extends StatefulWidget {
  @override
  _FinderCardsState createState() => new _FinderCardsState();
}

class _FinderCardsState extends State<FinderCards> with FinderCardView{

  FinderCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FinderCardPresenter()
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}