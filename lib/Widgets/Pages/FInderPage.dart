import 'package:findpairs/PresenterViews/Pages/FInderPageView.dart';
import 'package:findpairs/Presenters/Pages/FInderPagePresenter.dart';
import 'package:findpairs/Widgets/Components/Buttons/PauseActionButton.dart';
import 'package:findpairs/Widgets/Components/Cards/FInderCards.dart';
import 'package:findpairs/Widgets/Components/Cards/StackedCards.dart';
import 'package:findpairs/Widgets/Components/Lists/FInderLifes.dart';
import 'package:findpairs/Widgets/Components/Text/FinderCorrectRatioText.dart';
import 'package:findpairs/Widgets/Components/Text/FinderScoreText.dart';
import 'package:findpairs/Widgets/Pages/WrapperPage.dart';
import 'package:flutter/material.dart';

class FinderPage extends StatefulWidget {
  @override
  _FinderPageState createState() => new _FinderPageState();
}

class _FinderPageState extends State<FinderPage> with FinderPageView{


  FinderPagePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FinderPagePresenter()..setView = this..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      leftHeader: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          "Finder",
          style: Theme.of(context).textTheme.display1.apply(
            color: Colors.white
          ),
        ),
      ),
      actions: <Widget>[
        PauseActionButton(
          sinker: presenter.pauseSink,
        )
      ],
      child: Container(
        height: stackedHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: StackedCards(
                        stackedSink: presenter.stackedCardSink,
                        cardPaired: presenter.cardPairedStream,
                        boardCardStream: presenter.boardCardStream,
                      ),
                    ),
                    
                    Expanded(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: FinderScoreText(
                            increaseScore: presenter.increaseScoreStream,
                            reduceScore: presenter.reduceScoreStream,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: FinderCorrectRatioText(
                            updateRatio: presenter.ratioUpdateStream,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: FinderLifes()
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FinderCards(
                  stackedStream: presenter.stackedCardStream,
                  boardCardSink: presenter.boardCardSink,
                  cardPairedSink: presenter.cardPairedSink,
                  increaseScore: presenter.increaseScoreSink,
                  reduceScore: presenter.reduceScoreSink,
                  ratioUpdateSink: presenter.ratioUpdateSink,
                ),
              ),
            ),

            Container(
              height: 80,
            )
          ],
        ),
      ),
    );
  }

  @override
  BuildContext currentContext() {
    return context;
  }

}