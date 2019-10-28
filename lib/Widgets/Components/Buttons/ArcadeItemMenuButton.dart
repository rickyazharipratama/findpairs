import 'package:flutter/material.dart';

class ArcadeItemMenuButton extends StatelessWidget {

  final VoidCallback onTap;
  final String title;
  final Color color;

  ArcadeItemMenuButton({@required this.onTap, @required this.title, @required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xffe8e8ef),
          border: Border.all(
            color: Color(0xffdadadf),
            width: 2
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.display4.apply(
              color: this.color
            ),
          ),
        ),
      ),
    );
  }
}