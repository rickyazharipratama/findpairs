import 'package:flutter/material.dart';

class LandingPageMenuItem extends StatefulWidget {

  final bool isActive;
  final Map<String,dynamic> menu;
  LandingPageMenuItem({this.isActive, this.menu});

  @override
  _LandingPageMenuItemState createState() => new _LandingPageMenuItemState();
}

class _LandingPageMenuItemState extends State<LandingPageMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isActive ? EdgeInsets.all(0) : EdgeInsets.fromLTRB(15, 25, 15, 10),
      child: Material(
        elevation: widget.isActive ? 2 : 0,
      ),
    );
  }
}