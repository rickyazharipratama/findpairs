import 'package:findpairs/PresenterViews/Components/Text/LandingPageTitleView.dart';
import 'package:findpairs/Presenters/Components/Text/LandingPageTitlePresenter.dart';
import 'package:flutter/material.dart';

class LandingPageTitle extends StatefulWidget {

  final Stream<Map<String,dynamic>> stream;

  LandingPageTitle({this.stream});

  @override
  _LandingPageTitleState createState() => new _LandingPageTitleState();
}

class _LandingPageTitleState extends State<LandingPageTitle> with LandingPageTitleView{

  LandingPageTitlePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = LandingPageTitlePresenter(widget.stream)..setView = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: presenter.title == null ? Container() :  Text(presenter.title['name']),
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
}