import 'package:flutter/material.dart';

class ArcadeItemMenuButton extends StatelessWidget {

  final Color bgColor;
  final VoidCallback onTap;
  final String title;

  ArcadeItemMenuButton({ this.bgColor : Colors.white, @required this.onTap, @required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        padding: const EdgeInsets.all(10),
        height: 50,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.display3,
          ),
        ),
      ),
    );
  }
}