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
  final Stream<Map<String,int>> scoreAnimationStream;
  final Stream<bool> restrictionCardStream;
  final VoidCallback forceRestrictCard;
  

  FinderFlipCard({
    @required this.width,
    @required this.height,
    @required this.value,
    @required this.cardPaired,
    @required this.valChangeStream,
    @required this.scoreAnimationStream,
    @required this.restrictionCardStream,
    @required this.forceRestrictCard
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
    setScoreAnimationController = this;
    presenter = FinderFlipCardPresenter(
      cardPairedSink: widget.cardPaired,
      valueChangeStream: widget.valChangeStream,
      val: widget.value,
      scoreAnimationStream: widget.scoreAnimationStream,
      restrictingCardStream: widget.restrictionCardStream,
      forceRestrictCard: widget.forceRestrictCard
    )
    ..setView = this
    ..initiateData();
  }

  @override
  void didUpdateWidget(FinderFlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(this.widget.value != oldWidget.value){
      presenter.val = this.widget.value;
      notifyState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translation(shakingCard(shakingAnimationController.value)),
      child: FlipView(
        animationController: animationController,
        front: BackCard(
          episode: "Episode-01",
          height: widget.height,
          width: widget.width,
          onTap: presenter.ontapCard,
        ),
        
        back: Container(
          width: widget.width,
          height: widget.height,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: FinderFrontCard(
                  height: widget.height,
                  width: widget.width,
                  val: presenter.val,
                ),
              ),
              
              Positioned(
                top: scoreTranslateAnimation.value,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: scoreOpacityAnimation.value,
                  child: Text(
                    presenter.scoreAnimation > 0 ? "+"+presenter.scoreAnimation.toString() : presenter.scoreAnimation.toString(),
                  
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: presenter.scoreAnimation > 0 ? Colors.green : Colors.red,
                      fontFamily: Theme.of(context).textTheme.display1.fontFamily,
                      fontSize: Theme.of(context).textTheme.display1.fontSize,
                      shadows: [
                        Shadow(
                          offset: Offset(0,5),
                          color: Color(0xff000000),
                          blurRadius: 8
                        )
                      ]
                    )
                  ),
                ),
              ),
            ],
          ),
        )
      )
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
  double getCardHeight() {
    return widget.height;
  }
  
  @override
  BuildContext currentContext() => context;

  @override
  void dispose() {
    super.dispose();
    presenter.dispose();
  }
}