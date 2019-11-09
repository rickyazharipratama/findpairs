import 'package:flutter/material.dart';

class VerticalFormText extends StatelessWidget {

  final String label;
  final String value;

  VerticalFormText({this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          maxLines: 1,
          style: Theme.of(context).textTheme.display3.apply(
            color: Colors.white
          ),
        ),
        
        Text(
          value,
          textAlign: TextAlign.right,
          maxLines: 1,
          style: Theme.of(context).textTheme.display3.apply(
            color: Colors.white
          ),
        ),
      ],
    );
  }
}