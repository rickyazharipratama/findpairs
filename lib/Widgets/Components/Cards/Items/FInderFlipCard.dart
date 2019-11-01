import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Cards/Items/FinderFlipCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/Item/FinderFlipCardPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/BackCard.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FinderFrontCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

class FinderFlipCard extends StatefulWidget {

  final double width;
  final double height;
  final int value;
  final StreamSink<int> cardPaired;
  final Stream<Map<String,int>> valChangeStream;

  FinderFlipCard({
    @required this.width,
    @required this.height,
    @required this.value,
    @required this.cardPaired,
    @required this.valChangeStream
  });

  @override
  _FinderFlipCardState createState() => new _FinderFlipCardState();
}

class _FinderFlipCardState extends State<FinderFlipCard> with TickerProviderStateMixin,FinderFlipCardView{

  FinderFlipCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    setShakingAnimationController = this;
    presenter = FinderFlipCardPresenter(
      cardPairedSink: widget.cardPaired,
      valueChangeStream: widget.valChangeStream,
      val: widget.value
    )
    ..setView = this;
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translation(shakingCard(shakingAnimationController.value)),
      child: GestureDetector(
        onTap: presenter.ontapCard,
        child: FlipView(
          animationController: animationController,
          back: BackCard(
            episode: "Episode-01",
            height: widget.height,
            width: widget.width,
            onTap: presenter.ontapCard,
          ),
          
          front: FinderFrontCard(
            height: widget.height,
            width: widget.width,
            val: presenter.val,
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
  }@override
  void dispose() {
    super.dispose();
    presenter.dispose();
  }
}