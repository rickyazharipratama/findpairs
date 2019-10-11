import 'package:findpairs/PresenterViews/Components/Cards/CardView.dart';
import 'package:findpairs/Presenters/Components/Cards/ArcadeCardPreseneter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FlipCard.dart';
import 'package:flutter/material.dart';

class ArcadeCard extends StatefulWidget {
  final int stage;

  ArcadeCard({this.stage});
  
  @override
  _ArcadeCardState createState() => new _ArcadeCardState();
}

class _ArcadeCardState extends State<ArcadeCard> with CardView{

  ArcadeCardPresenter presenter = ArcadeCardPresenter();

  @override
  void initState() {
    super.initState();
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {

    double cardWidth = getCardWidth(2, 2);
    double cardHeight = getCardHeight(cardWidth);

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                

                FlipCard(
                  width: cardWidth,
                  height: cardHeight,
                  flipBack: presenter.flipBack,
                  streamCard: presenter.selectedCardSinker,
                  value: "1",
                ),

                FlipCard(
                  width: cardWidth,
                  height: cardHeight,
                  flipBack: presenter.flipBack,
                  streamCard: presenter.selectedCardSinker,
                  value: "3",
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                FlipCard(
                  width: cardWidth,
                  height: cardHeight,
                  flipBack: presenter.flipBack,
                  streamCard: presenter.selectedCardSinker,
                  value: "3",
                ),

                FlipCard(
                  width: cardWidth,
                  height: cardHeight,
                  flipBack: presenter.flipBack,
                  streamCard: presenter.selectedCardSinker,
                  value: "1",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }
}