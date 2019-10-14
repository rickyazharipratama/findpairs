import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/Items/FlipCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/Item/FlipCardPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/BackCard.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FrontCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

class FlipCard extends StatefulWidget{

  final double width;
  final double height;
  final Stream<String> flipBack;
  final Stream<bool> restrictFlip;
  final StreamSink streamCard;
  final String value;

  FlipCard({@required this.width, @required this.height, @required this.flipBack, @required this.streamCard, @required this.restrictFlip,@required this.value});

  @override
  _FLipCardState createState() => new _FLipCardState();
}

class _FLipCardState extends State<FlipCard> with SingleTickerProviderStateMixin,FlipCardView {

  FlipCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FlipCardPresenter(widget.flipBack, widget.streamCard,widget.restrictFlip,widget.value)..setView = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return FlipView(
      animationController: animation,
      front: BackCard(
          onTap: presenter.isRestrictFlipCard ? (){} : presenter.onTapCard,
          height: widget.height,
          width: widget.width,
      ),
      back: FrontCard(
        height: widget.height,
        width: widget.width,
        value: widget.value,
      ),
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  TickerProvider ticker() => this;

  @override
  void notifyState(){
    if(mounted){
      setState(() {
        
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}