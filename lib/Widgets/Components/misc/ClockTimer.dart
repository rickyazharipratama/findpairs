import 'dart:async';

import 'package:findpairs/PresenterViews/Components/misc/ClockTImerView.dart';
import 'package:findpairs/Presenters/Components/misc/ClockTimerPresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/material.dart';

class ClockTimer extends StatefulWidget {
  final int counter;
  final int critTime;
  final StreamSink<ArcadeTimer> sinker;
  final Stream<ArcadeTimer> stream;
  final StreamSink<int> timerSink;

  ClockTimer({@required this.counter, @required this.sinker, @required this.critTime, @required this.stream, @required this.timerSink});

  @override
  _ClockTimerState createState() => new _ClockTimerState();
}

class _ClockTimerState extends State<ClockTimer> with TickerProviderStateMixin, ClockTimerView{

  CLockTimerPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = CLockTimerPresenter(widget.counter, widget.critTime,widget.sinker, widget.stream, widget.timerSink)..setView = this;
    setAnimationController = this;
    presenter.initiateData();
  }

  @override
  void didUpdateWidget(ClockTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    presenter.setCountDown = widget.counter;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1 + anim.value,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            presenter.countDown.toString(),
            style: Theme.of(context).textTheme.display2.apply(
              color: Colors.white
            ),
          ),
        ),
      )
    );
  }


  @override
  BuildContext currentContext() {
    return context;
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
    presenter.dispose();
    super.dispose();
  }
}