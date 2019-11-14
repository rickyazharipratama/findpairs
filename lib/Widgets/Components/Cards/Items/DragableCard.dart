import 'package:findpairs/PresenterViews/Components/Cards/Items/DragableCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/Item/DragableCardPresenter.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/BackCard.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FinderFrontCard.dart';
import 'package:flutter/material.dart';

class DragableCard extends StatefulWidget {

  final double cardWidth;
  final double cardHeight;
  final int val;
  final VoidCallback draggedCallback;
  
  DragableCard({@required this.cardHeight, @required  this.cardWidth, @required this.val, @required this.draggedCallback, Key key}) : super(key : key);

  @override
  DragableCardState createState() => DragableCardState();
}

class DragableCardState extends State<DragableCard> with DragableCardView{
  
  DragableCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = DragableCardPresenter(
      draggedComplete: widget.draggedCallback,
      val: widget.val
    )
    ..setView = this
    ..initiateData();
  }

  @override
  void didUpdateWidget(DragableCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.val != this.widget.val){
      presenter.resetDragAccepted(
        val: this.widget.val
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return presenter.isDragAccepted ? 
      BackCard(
        episode: "Episode-01",
        height: widget.cardHeight,
        width: widget.cardWidth,
        onTap: (){},
        margin: const EdgeInsets.all(0),
      )
    : Draggable<int>(
        data: presenter.value,
        child: FinderFrontCard(
          height: widget.cardHeight,
          width: widget.cardWidth,
          val: presenter.value,
        ),
        feedback:FinderFrontCard(
          height: widget.cardHeight,
          width: widget.cardWidth,
          val: presenter.value,
        ),
        childWhenDragging: BackCard(
          episode: "Episode-01",
          height: widget.cardHeight,
          width: widget.cardWidth,
          onTap: (){},
          margin: const EdgeInsets.all(0),
        ),
        onDragCompleted: presenter.cardAlreadyAccepted,
      );
  }

  @override
  BuildContext currentContext() {
    return context;
  }

  @override
  void notifyState() {
    super.notifyState();
    if(mounted){
      setState(() {
        
      });
    }
  }
}