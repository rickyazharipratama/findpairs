import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:flutter/material.dart';

class BackCard extends StatelessWidget {

  final double height;
  final double width;
  final String episode;
  final VoidCallback onTap;

  BackCard({@required this.height, @required this.width, @required this.onTap, @required this.episode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((this.width/100)*10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ConstantCollections.backCards[episode]['color'],
              ConstantCollections.backCards[episode]['gradientColor']
            ],
            stops: [0,0.8]
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: (this.width / 100) * 15,
              color: Color(0xaa555555),
              offset: Offset(1,10)
            )
          ]
        ),
        child: Center(
          child: Image.asset(
            ConstantCollections.backCards[episode]['icon'],
            width: (width) /2,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}