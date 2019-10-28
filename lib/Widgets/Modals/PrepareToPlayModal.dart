import 'package:findpairs/PresenterViews/Modals/PrepareToPlayView.dart';
import 'package:findpairs/Presenters/Modals/PrepareToPlayModalPresenter.dart';
import 'package:flutter/material.dart';

class PrepareToPlay extends StatefulWidget {
  @override
  _PrepareToPlayState createState() => new _PrepareToPlayState();
}

class _PrepareToPlayState extends State<PrepareToPlay> with TickerProviderStateMixin,PrepareToPlayView{

  PrepareToPlayModalPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = PrepareToPlayModalPresenter()..setView = this..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: opct.value,
        child: Transform.scale(
          scale: zoomOut.value,
          child: Text(
            message,
            style: Theme.of(context).textTheme.display2.apply(
              color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        ),
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
  BuildContext currentContext() {
    return context;
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }
}