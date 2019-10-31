import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:flutter/material.dart';

class FinderFrontCard extends StatefulWidget {
  
  final double width;
  final double height;
  final int val;


  FinderFrontCard({
    @required this.width,
    @required this.height,
    @required this.val
  });

  @override
  _FinderFrontCardState createState() => new _FinderFrontCardState();
}

class _FinderFrontCardState extends State<FinderFrontCard> {
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