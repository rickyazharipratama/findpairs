import 'package:dotted_border/dotted_border.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:flutter/material.dart';

class DottedCard extends StatelessWidget {

  final double cardWidth;
  final double cardHeight;

  DottedCard({@required this.cardWidth, @required this.cardHeight});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: Radius.circular((cardWidth / 100) * 10),
      color: Colors.white,
      borderType: BorderType.RRect,
      padding: const EdgeInsets.all(5),
      strokeWidth: 2,
      child: SizedBox(
        height: cardHeight - 10,
        width: cardWidth - 10 ,
        child: Center(
        child: Image.asset(
          ConstantCollections.backCards["Episode-01"]["icon"],
          width: cardWidth / 2,
          fit: BoxFit.fitWidth,
          color: Colors.white,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
      ),
    );
  }
}