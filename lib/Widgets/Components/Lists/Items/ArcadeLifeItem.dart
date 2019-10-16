import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeLifeItemView.dart';
import 'package:findpairs/Presenters/Components/Lists/Items/ArcadeLIfeItemPresenter.dart';
import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class ArcadeLifeItem extends StatefulWidget {
  final Stream<int> lifeStream;
  final StreamSink<bool> sinker;
  final int tag;

  ArcadeLifeItem({this.lifeStream, this.sinker,this.tag});

  @override
  _ArcadeLifeItemState createState() => new _ArcadeLifeItemState();
}

class _ArcadeLifeItemState extends State<ArcadeLifeItem> with TickerProviderStateMixin, ArcadeLifeItemView{

  ArcadeLifeItemPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = ArcadeLifeItemPresenter(widget.lifeStream, widget.sinker,widget.tag)..setView = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return viewMode == 0 ?
    Transform.rotate(
      angle: animation.value,
      child: IconShadowWidget(
        Icon(
          Icons.favorite,
          color: Colors.red,
          size: 40,
        ),
        shadowColor: Color(0xff333333),
        showShadow: true,
      )
    ) : Container();
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