import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeLifeItemExtendedView.dart';
import 'package:findpairs/Presenters/Components/Lists/Items/ArcadeLifeItemExtendedPresenter.dart';
import 'package:flutter/material.dart';

class ArcadeLifeItemExtended extends StatefulWidget {
  final int lifeExtended;
  final StreamSink<bool> disposeWidget;
  final Stream<int> lifeExtendedStream;

  ArcadeLifeItemExtended({this.lifeExtended, this.disposeWidget, this.lifeExtendedStream});

  @override
  _ArcadeLifeItemExtendedState createState() => new _ArcadeLifeItemExtendedState();
}

class _ArcadeLifeItemExtendedState extends State<ArcadeLifeItemExtended> with TickerProviderStateMixin,ArcadeLifeItemExtendedView{

  ArcadeLifeItemExtendedPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = ArcadeLifeItemExtendedPresenter(widget.lifeExtended, widget.disposeWidget, widget.lifeExtendedStream)..setView = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle:anim.value,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.yellow,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xff333333),
              blurRadius: 1,
              offset: Offset(0.2,0.2)
            )
          ]
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
              text: "+"+presenter.lifeExtended.toString(),
              style: Theme.of(context).textTheme.display3
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  void notifyState(){
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