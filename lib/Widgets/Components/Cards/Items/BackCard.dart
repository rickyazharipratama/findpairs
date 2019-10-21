import 'package:flutter/material.dart';

class BackCard extends StatelessWidget {

  final double height;
  final double width;
  final VoidCallback onTap;

  BackCard({@required this.height, @required this.width, @required this.onTap});

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
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              blurRadius: (this.width / 100) * 15,
              color: Color(0xaa555555),
              offset: Offset(1,10)
            )
          ]
        ),
      ),
    );
  }
}