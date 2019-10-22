import 'dart:async';

import 'package:findpairs/Models/ArcadeCardValue.dart';
import 'package:findpairs/PresenterViews/Components/Cards/Items/FlipCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/Item/FlipCardPresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/BackCard.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FrontCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

class FlipCard extends StatefulWidget{

  final double width;
  final double height;
  final Stream<int> flipBack;
  final Stream<bool> restrictFlip;
  final Stream<ArcadeTimer> arcadeTime;
  final Stream<int> paired;
  final StreamSink streamCard;
  final ArcadeCardValue value;

  FlipCard({@required this.width, @required this.height, @required this.flipBack, @required this.streamCard, @required this.restrictFlip,@required this.value, @required this.paired, @required this.arcadeTime});

  @override
  _FLipCardState createState() => new _FLipCardState();
}

class _FLipCardState extends State<FlipCard> with TickerProviderStateMixin,FlipCardView {

  FlipCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FlipCardPresenter(widget.flipBack, widget.streamCard,widget.restrictFlip,widget.arcadeTime,widget.value)..setView = this;
    presenter.initiateData();
  }

  @override
  void didUpdateWidget(FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.value != presenter.value){
      presenter.reinitiateCard();
      presenter.setValue = widget.value;
      notifyState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform:  isStartShaking ? Matrix4.translation(getShakingTranslation(
        progress: vibrateAnimation.value
      )) : Matrix4.rotationX(0),
      child: FlipView(
        animationController: animationController,
        front: BackCard(
          onTap: presenter.isRestrictFlipCard ? (){} : presenter.onTapCard,
          height: widget.height,
          width: widget.width,
        ),
        back: FrontCard(
          height: widget.height,
          width: widget.width,
          paired: widget.paired,
          value: presenter.value,
        )
      )
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
    vibrateController?.stop();
    vibrateController.dispose();
    animationController.dispose();
    super.dispose();
  }
}