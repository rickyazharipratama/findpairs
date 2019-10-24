import 'package:flutter/material.dart';

class LockStageSelection extends StatelessWidget {

  final int stage;
  final double width;
  final double height;
  LockStageSelection({@required this.stage, @required this.width, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Expanded(
            child: Stack(
              children: <Widget>[

                Positioned.fill(
                  top: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffe6e7e9),
                    ),
                    child: Center(
                      child: Text(
                        stage.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.display4,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(
                      Icons.lock,
                      color: Color(0xff64696e),
                      size: width / 3,
                    ),
                  ),
                )
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 5),
            height: 45,
          )
        ],
      ),
    );
  }
}