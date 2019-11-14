import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:flutter/material.dart';

class FinderFrontCard extends StatefulWidget {
  
  final double width;
  final double height;
  final int val;


  FinderFrontCard({
    @required this.width,
    @required this.height,
    @required this.val,
    Key key
  }) : super(key : key);

  @override
  FinderFrontCardState createState() => FinderFrontCardState();
}

class FinderFrontCardState extends State<FinderFrontCard> {

  @override
  void didUpdateWidget(FinderFrontCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.val != this.widget.val){
      if(mounted){
        setState(() { 
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular((widget.width / 100)*10),
      ),
      child: Center(
        child: Image.asset(
          ConstantCollections.cards["Episode-01"][widget.val],
          width: (widget.width * 3) / 4,
          fit: BoxFit.fitWidth,
        )
      ),
    );
  }
}