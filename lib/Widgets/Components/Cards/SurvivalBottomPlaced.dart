import 'dart:ui';

import 'package:findpairs/PresenterViews/Components/Cards/SurvivalBottomPlacedView.dart';
import 'package:findpairs/Widgets/Components/Cards/DragTargetCard.dart';
import 'package:flutter/material.dart';

class SurvivalBottomPlaced extends StatefulWidget {

  final double cardWidth;
  final double cardHeight;

  SurvivalBottomPlaced({@required this.cardWidth, @required this.cardHeight});

  @override
  _SurvivalBottomPlacedState createState() => new _SurvivalBottomPlacedState();
}

class _SurvivalBottomPlacedState extends State<SurvivalBottomPlaced> with SurvivalBottomPlacedView{



  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8
        ),
        child: Container(
          height: wrapperHeight(widget.cardHeight),
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5 + MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: Color(0x55333333),
          ),
          child: Stack(
            children: <Widget>[

              Positioned(
                top: 0,
                left: 10,
                child: DragTargetCard(
                  height: widget.cardHeight,
                  width: widget.cardWidth,
                )
              ),

              Positioned(
                top: 0,
                left: (widget.cardWidth + 20),
                child: DragTargetCard(
                  height: widget.cardHeight,
                  width: widget.cardWidth,
                )
              ),

              Positioned(
                top: 0,
                left: ((widget.cardWidth * 2) + 30),
                child: DragTargetCard(
                  height: widget.cardHeight,
                  width: widget.cardWidth,
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  BuildContext currentContext() {
    return context;
  }

  @override
  void noitfyState() {
    super.noitfyState();
    if(mounted){
      setState(() {
        
      });
    }
  }

}