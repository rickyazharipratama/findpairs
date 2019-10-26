import 'package:flutter/material.dart';

class WrapperPage extends StatelessWidget {

  final Widget leftHeader;
  final List<Widget> actions;
  final Widget child;

  WrapperPage({@required this.leftHeader, @required this.actions, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Material(
          clipBehavior: Clip.hardEdge,
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: <Widget>[


              Positioned.fill(
                child: Image.asset(
                  "assets/images/bg.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),

              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top+5, 0, MediaQuery.of(context).padding.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Container(
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: leftHeader,
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
              )
            ],
          )
        )
      )
    );
  }
}