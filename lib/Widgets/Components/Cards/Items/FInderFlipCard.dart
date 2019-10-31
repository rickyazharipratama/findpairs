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

  FinderFlipCard({
    @required this.width,
    @required this.height,
    @required this.value
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
    presenter = FinderFlipCardPresenter()
    ..setView = this;
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translation(shakingCard(shakingAnimationController.value)),
      child: FlipView(
        animationController: animationController,
        back: BackCard(
          episode: "Episode-01",
          height: widget.height,
          width: widget.width,
          onTap: (){},
        ),
        front: FinderFrontCard(
          height: widget.height,
          width: widget.width,
          val: widget.value,
        ),
      ),
    );
  }
}