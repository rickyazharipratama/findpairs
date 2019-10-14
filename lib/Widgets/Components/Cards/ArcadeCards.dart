import 'package:findpairs/PresenterViews/Components/Cards/CardView.dart';
import 'package:findpairs/Presenters/Components/Cards/ArcadeCardPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FlipCard.dart';
import 'package:flutter/material.dart';

class ArcadeCard extends StatefulWidget {
  final int stage;
  final String episode;

  ArcadeCard({this.stage, this.episode});
  
  @override
  _ArcadeCardState createState() => new _ArcadeCardState();
}

class _ArcadeCardState extends State<ArcadeCard> with CardView{

  ArcadeCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = ArcadeCardPresenter(widget.stage, widget.episode)..setView = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {

    double cardWidth = getCardWidth(presenter.setting.horizontal, presenter.setting.vertical);
    double cardHeight = getCardHeight(cardWidth);

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: presenter.setting.formations.map((formations){
            List<int> rows = List();
            for(int i = 0; i  < formations.row; i++){
              rows.add(i);
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: rows.map((row){
                return FlipCard(
                  width: cardWidth,
                  height: cardHeight,
                  restrictFlip: presenter.restrictFlip,
                  flipBack: presenter.flipBack,
                  streamCard: presenter.selectedCardSinker,
                  value: presenter.getAvailableCardValue().value,
                );
              }).toList(),
            );
          }).toList()
        ),
      ),
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  void notifyState() {
    super.notifyState();
    if(mounted){
      setState(() {});
    }
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }
}