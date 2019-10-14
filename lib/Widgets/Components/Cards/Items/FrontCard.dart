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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          value
        ),
      ),
    );
  }
}