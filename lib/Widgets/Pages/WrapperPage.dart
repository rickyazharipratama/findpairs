import 'package:flutter/material.dart';

class WrapperPage extends StatelessWidget {

  final Widget leftHeader;
  final List<Widget> actions;
  final Widget child;

  WrapperPage({@required this.leftHeader, @required this.actions, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Color(0xff8f6d68),
      child: Stack(
        children: <Widget>[
          
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg_landing_page.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              alignment: Alignment.center,
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
          )
        ],
      )
    );
  }
}