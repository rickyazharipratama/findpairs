import 'package:findpairs/PresenterViews/Components/Cards/DragTargetCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/DragTargetCardPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/DottedCard.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FinderFrontCard.dart';
import 'package:flutter/material.dart';

class DragTargetCard extends StatefulWidget {

  final double height;
  final double width;

  DragTargetCard({@required this.height, @required this.width});
  @override
  _DragTargetCardState createState() => new _DragTargetCardState();
}

class _DragTargetCardState extends State<DragTargetCard> with DragTargetCardView{
  
  DragTargetCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = DragTargetCardPresenter()
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      builder: (context,_,__)=>
        presenter.targetVal >= 0 && presenter.targetVal <= 32?
          FinderFrontCard(
            height: widget.height,
            width: widget.width,
            val: presenter.targetVal,
          )
        : DottedCard(
          cardHeight: widget.height,
          cardWidth: widget.width,
        ),
      
      onWillAccept: (val){
        return true;
      },
      onAccept: presenter.updatingTargetVal,
      onLeave: presenter.resetTargetVal,
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  void notifyState() {
    super.notifyState();
    if(mounted){
      setState(() {
        
      });
    }
  }

}