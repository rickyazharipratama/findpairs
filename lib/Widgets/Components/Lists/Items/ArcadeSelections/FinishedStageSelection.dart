import 'package:findpairs/Widgets/Pages/StagesPage.dart';
import 'package:flutter/material.dart';

class FinishedStageSelection extends StatelessWidget {

  final double width;
  final double height;
  final int stage;
  final String episode;
  final int star;

  FinishedStageSelection({
    @required this.width,
    @required this.height,
    @required this.stage,
    @required this.episode,
    @required this.star
  });

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
                      color: Color(0xfff7f5cb),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(0,10),
                          color: Color(0xffc1c0c7)
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        stage.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.display3,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Transform.rotate(
                          angle: -0.1,
                          child: Icon(
                            star > 1 ? Icons.star : Icons.star_border,
                            size: (width /3) - 5,
                            color: Colors.yellow,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Icon(
                          Icons.star,
                          size: width / 3,
                          color: Colors.yellow,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Transform.rotate(
                          angle: 0.1,
                          child: Icon(
                            star > 2 ? Icons.star : Icons.star_border,
                            size: (width/3) - 5,
                            color: Colors.yellow,
                          ),
                        ),
                      )
                    ],
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
                      color: Color(0xffc1c0c7)
                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    "RETRY",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display3,
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