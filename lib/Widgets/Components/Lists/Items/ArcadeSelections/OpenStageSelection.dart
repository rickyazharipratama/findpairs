import 'package:findpairs/Widgets/Pages/StagesPage.dart';
import 'package:flutter/material.dart';

class OpenStageSelection extends StatelessWidget {

  final String episode;
  final int stage;
  final double width;
  final double height;

  OpenStageSelection({@required this.episode,@required this.stage, @required this.width , @required this.height});

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
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2
                      ),
                      color: Color(0xfff4efa9),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(0,10),
                          color: Color(0xff333333)
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        stage.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.display4.apply(
                          color: Color(0xfff77d00)
                        ),

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StagesPage(
                    episode: episode,
                    stage: stage,
                  )
                ));
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xfffaa675),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0,10),
                      color: Color(0x99333333)
                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    "PLAY",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display4.apply(
                      color: Color(0xfff7f5cb)
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}