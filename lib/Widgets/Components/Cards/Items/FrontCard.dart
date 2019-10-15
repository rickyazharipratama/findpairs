import 'package:flutter/material.dart';

class FrontCard extends StatelessWidget {

  final double width;
  final double height;
  final String value;

  FrontCard({@required this.width, @required this.height, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular((this.width / 100)*10),
        boxShadow: [
          BoxShadow(
            blurRadius: (this.width / 100) * 15,
            color: Color(0xaa555555),
            offset: Offset(1,10)
          )
        ]
      ),
      child: Center(
        child: Text(
          value
        ),
      ),
    );
  }
}