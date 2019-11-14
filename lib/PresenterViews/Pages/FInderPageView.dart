import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/content_target.dart';
import 'package:tutorial_coach_mark/target_focus.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class FinderPageView{


  GlobalKey stackedCardItemKey = GlobalKey();
  GlobalKey flipCardKey = GlobalKey();

  double get stackedHeight{
    return (MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom)) * 0.2;
  }

  showTutorial(VoidCallback onFinished){
    List<TargetFocus> tf = [
      TargetFocus(
        identify: "target1",
        keyTarget: stackedCardItemKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Text(
                    "Opened Card!",
                    style: Theme.of(currentContext()).textTheme.display1.apply(
                      color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "This card is used as a reference to find a partner in a closed card.",
                      style: Theme.of(currentContext()).textTheme.display3.apply(
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            )
          )
        ]
      ),
      TargetFocus(
        identify: "target2",
        keyTarget: flipCardKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Text(
                    "Closed Cards!",
                    style: Theme.of(currentContext()).textTheme.display1.apply(
                      color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "Cards that have random content where one of them is a pair of opened card.",
                      style: Theme.of(currentContext()).textTheme.display3.apply(
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            )
          )
        ]
      ),
    ];

    TutorialCoachMark(
      currentContext(),
      targets: tf,
      alignSkip: Alignment.bottomRight,
      textStyleSkip: Theme.of(currentContext()).textTheme.display3.apply(
        color: Colors.white
      ),
      finish: onFinished
    )..show();
  }

  void closePage(){
    Navigator.of(currentContext()).pop();
  }

  BuildContext currentContext() => null;
}