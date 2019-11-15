import 'package:findpairs/PresenterViews/Pages/LandingPageView.dart';
import 'package:findpairs/Presenters/Pages/LandingPagePresenter.dart';
import 'package:findpairs/Widgets/Components/Buttons/SoundActionButton.dart';
import 'package:findpairs/Widgets/Components/Lists/LandingPageMenu.dart';
import 'package:findpairs/Widgets/Components/Text/LandingPageTitle.dart';
import 'package:findpairs/Widgets/Pages/WrapperPage.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with WidgetsBindingObserver,LandingPageView{

  final LandingPagePresenter presenter = LandingPagePresenter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    presenter.setView  = this;
    presenter.initiateData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused){
      presenter.pauseBackgroundMusic();
    }else if(state == AppLifecycleState.resumed){
      presenter.playBackgroundMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      leftHeader: Container(),
      actions: <Widget>[
        SoundActionButton(
          notifyReactiveStream: presenter.notifyReactiveStream,
        )
      ],
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: LandingPageMenu(
              notifyReactiveSink: presenter.notifyReactiveSink,
              streamController: presenter.streamController,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 100,
              child: LandingPageTitle(
                stream: presenter.stream,
              ),
            ),
          )
        ],
      )
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}