import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Modals/CompleteArcadeModal.dart';
import 'package:findpairs/Widgets/Modals/NegativeArcadeModal.dart';
import 'package:findpairs/Widgets/Modals/PrepareToPlayModal.dart';
import 'package:findpairs/Widgets/Pages/ArcadeSeeYouNextEpisode.dart';
import 'package:flutter/material.dart';
import 'package:navigatorium/navigatorium.dart';
import 'package:tutorial_coach_mark/content_target.dart';
import 'package:tutorial_coach_mark/target_focus.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class CardView{

  BuildContext currentContext() => null;

  GlobalKey cardKey = GlobalKey();
  GlobalKey timeKey = GlobalKey();
  GlobalKey lifeKey = GlobalKey();

  void notifyState(){}

  double getWidth() => MediaQuery.of(currentContext()).size.width-20;
  double getHeight() => MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + 180);

  double getCardWidth(int horizontal, int vertical){

    double cardWidth = ((getWidth() - (10 * horizontal)) / horizontal);
    double tempHeight = getCardHeight(cardWidth);
    double totalTempHeight = (tempHeight+10) * vertical;
    CommonUtil.instance.showLog(log:"total temp height : "+totalTempHeight.toString());
    CommonUtil.instance.showLog(log:"space height : "+ getHeight().toString());

    while (totalTempHeight >= getHeight()){
      cardWidth-= 2;
      totalTempHeight = (getCardHeight(cardWidth) + 10) * vertical;
      CommonUtil.instance.showLog(log:"total temp height : "+totalTempHeight.toString());
    }
    return cardWidth;
  }
  double getCardHeight(double width) => (width * 13 ) / 9;

  showTutorial({VoidCallback onFinished}){
    List<TargetFocus> tf = [
      TargetFocus(
        identify: "target1",
        keyTarget: cardKey,
        contents: [
          ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Text(
                    "Closed Card!",
                    style: Theme.of(currentContext()).textTheme.display1.apply(
                      color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "Open the closed card and find the a paired one from the another closed card.",
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
        keyTarget: timeKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Text(
                    "Count Down Time!",
                    style: Theme.of(currentContext()).textTheme.display1.apply(
                      color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "The time has been given to finish the game.",
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
        identify: "target3",
        keyTarget: lifeKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Text(
                    "Life!",
                    style: Theme.of(currentContext()).textTheme.display1.apply(
                      color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "The amount of chances given incorrectly opening a closed card.",
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

  Future<ArcadeAction> showNegativeDialog({
    String title,
    String episode
  }) async{
    return await showDialog(
      context: currentContext(),
      barrierDismissible: false,
      builder: (context) => NegativeArcadeModal(
        message: title,
        episode: episode,
      )
    );
  }

  void closeView(){
    Navigator.of(currentContext()).pop();
  }

  Future<ArcadeAction> showCompleteDialog({
    int star,
    String message,
    String episode
  }) async{
    return await showDialog(
      context:  currentContext(),
      barrierDismissible:  false,
      builder: (context) => CompleteArcadeModal(
        starScore: star,
        episode: episode,
        message: message,
      )
    );
  }

  Future<bool> prepareToPlay() async{
    return await showDialog(
      context: currentContext(),
      barrierDismissible: false,
      builder: (context) => PrepareToPlay()
    );
  }

  void goToClosingArcade(){
    Navigatorium.instance.changeWidget(
      currentContext(),
      child: ArcadeSeeYouNextEpisode()
    );
  }
}