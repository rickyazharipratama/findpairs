import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Components/Cards/DragTargetCard.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/DragableCard.dart';
import 'package:findpairs/Widgets/Components/Cards/Items/FinderFrontCard.dart';
import 'package:findpairs/Widgets/Components/misc/SurvivalScoreWrapper.dart';
import 'package:findpairs/Widgets/Modals/CompleteArcadeModal.dart';
import 'package:findpairs/Widgets/Modals/NegativeArcadeModal.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class SurvivalPageView{

  Size get cardSize{
    double width = (MediaQuery.of(currentContext()).size.width - 60) / 4;
    double stacked = (MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom)) * 0.15;
    double roomHeight = MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + stacked + 60 /* header */);

    while((getCardHeight(width) + 10) *  3 > roomHeight){
      width -= 1;
    }
    return Size(width,getCardHeight(width));
  }

  GlobalKey<DragableCardState> dragableCardKey = GlobalKey();
  GlobalKey<SurvivalScoreWrapperState> survivalScoreWrapperKey = GlobalKey();
  GlobalKey<DragTargetCardState> dragTargetCardKey = GlobalKey();
  GlobalKey<FinderFrontCardState> finderFrontCardKey = GlobalKey();

  showTutorial({
    VoidCallback onFinish
  }){

    List<TargetFocus> tf = [
      TargetFocus(
        identify: "target1",
        keyTarget: dragableCardKey,
        contents: [
          ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Text(
                    "Matching Card!",
                    style: Theme.of(currentContext()).textTheme.display1.apply(
                      color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "This card can be dragged into one of the card areas on left side to match with card that falls from the top.",
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
        keyTarget: dragTargetCardKey,
        contents: [
          ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Card Area!",
                    style: Theme.of(currentContext()).textTheme.display1.apply(
                      color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "The Matching card can be dropped in to on of this area that match with card that falls from the Top.",
                      style: Theme.of(currentContext()).textTheme.display3.apply(
                        color: Colors.white
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "After the matching card has been dropped. you can do long tap to speed up the card falls from the top",
                      style: Theme.of(currentContext()).textTheme.display3.apply(
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
        ]
      ),
      TargetFocus(
        identify: "target3",
        keyTarget: finderFrontCardKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Text(
                    "The Fall Down Cards!",
                    style: Theme.of(currentContext()).textTheme.display1.apply(
                      color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "The Fall down cards will generated randomly and one of them will match with matching card.",
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
        identify: "target4",
        keyTarget: survivalScoreWrapperKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Text(
                    "Score & Speed!",
                    style: Theme.of(currentContext()).textTheme.display1.apply(
                      color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      "When Matching Card is paired with fallen card, the score will increase also speed will increase after score has increased several times.",
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
      finish: onFinish
    )..show();
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
        negativeText: "EXIT",
        positiveText: "RETRY",
      )
    );
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

  double getCardHeight(double width) => (width * 13 ) / 9;

  BuildContext currentContext() => null;

  bool isMounted() => null;

  void notifyState(){}
}