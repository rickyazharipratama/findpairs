import 'package:flutter/material.dart';

class WrapperPage extends StatelessWidget {

  final Widget leftHeader;
  final List<Widget> actions;
  final Widget child;

  WrapperPage({@required this.leftHeader, @required this.actions, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top+5, 0, MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              Container(
                height: 75,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: actions,  
                    )
                  ],
                ),
              ),
              Expanded(
                child: child,
              )
          ],
        ),
      ),
    );
  }
}