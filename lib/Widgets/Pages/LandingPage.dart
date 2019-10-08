import 'package:findpairs/PresenterViews/Pages/LandingPageView.dart';
import 'package:findpairs/Presenters/Pages/LandingPagePresenter.dart';
import 'package:findpairs/Widgets/Components/Lists/LandingPageMenu.dart';
import 'package:findpairs/Widgets/Components/Text/LandingPageTitle.dart';
import 'package:findpairs/Widgets/Pages/WrapperPage.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with LandingPageView{

  final LandingPagePresenter presenter = LandingPagePresenter();

  @override
  void initState() {
    super.initState();
    presenter.setView  = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      leftHeader: Container(),
      actions: <Widget>[

      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: LandingPageMenu(
              streamController: presenter.streamController,
            ),
          ),
          Container(
            height: 100,
            child: LandingPageTitle(
              stream: presenter.stream,
            ),
          )
        ],
      ),
    );
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
    presenter.disposingStream();
    super.dispose();
  }
}