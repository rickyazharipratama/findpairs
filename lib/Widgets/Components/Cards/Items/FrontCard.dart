import 'package:findpairs/Models/ArcadeCardValue.dart';
import 'package:findpairs/PresenterViews/Components/Cards/Items/FrontCardView.dart';
import 'package:findpairs/Presenters/Components/Cards/Item/FrontCardPresenter.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:flutter/material.dart';

class FrontCard extends StatefulWidget {
  final double width;
  final double height;
  final ArcadeCardValue value;
  final Stream<int> paired;
  final String episode;

  FrontCard({
    @required this.width,
    @required this.height,
    @required this.value,
    @required this.paired,
    @required this.episode
  });

  @override
  _FrontCardState createState() => new _FrontCardState();
}

class _FrontCardState extends State<FrontCard> with FrontCardView{

  FrontCardPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FrontCardPresenter(widget.paired, widget.value)..setView = this..initiateData();
   
  }

  @override
  void didUpdateWidget(FrontCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(presenter.value != this.widget.value){
      presenter.setvalue = widget.value; 
      notifyState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular((widget.width / 100)*10),
        boxShadow: [
          BoxShadow(
            blurRadius: (widget.width / 100) * 15,
            color: Color(0xaa555555),
            offset: Offset(1,10)
          )
        ]
      ),
      child: Center(
        child: Image.asset(
          ConstantCollections.cards[widget.episode][presenter.value.value],
          width: (widget.width * 3) / 4,
          fit: BoxFit.fitWidth,
        )
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
  }
}