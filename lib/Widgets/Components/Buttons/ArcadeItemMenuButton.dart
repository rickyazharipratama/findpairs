import 'package:flutter/material.dart';

class ArcadeItemMenuButton extends StatelessWidget {

  final VoidCallback onTap;
  final String title;
  final Color color;

  ArcadeItemMenuButton({@required this.onTap, @required this.title, @required this.color});

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
          color: Color(0xffe8e8ef),
          border: Border.all(
            color: Color(0xffdadadf),
            width: 2
          ),
          borderRadius: BorderRadius.circular(5),
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