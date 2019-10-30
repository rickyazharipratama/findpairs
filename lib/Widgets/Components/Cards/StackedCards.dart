import 'package:findpairs/PresenterViews/Components/Cards/StackedCardsView.dart';
import 'package:flutter/material.dart';

class StackedCards extends StatefulWidget {
  @override
  _StackedCardsState createState() => new _StackedCardsState();
}

class _StackedCardsState extends State<StackedCards> with StackedCardsView{

  @override
  void initState() {
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        children: List.generate(5, (idx){
          double top = (2 * idx).toDouble();
          double side = 8 - (2 * idx).toDouble();
          return Positioned(
            top: top,
            left: side,
            right: side,
            child: Container(
              width: cardWidth - top,
              height: cardHeight - top,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                  )
                ]
              ),  
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  BuildContext currentContext() {
    return context;
  }
}