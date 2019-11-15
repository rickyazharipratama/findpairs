import 'package:findpairs/PresenterViews/Components/Text/FinderScoreTextView.dart';
import 'package:findpairs/Presenters/Components/Text/FinderScoreTextPresenter.dart';
import 'package:flutter/material.dart';

class FinderScoreText extends StatefulWidget {

  final Stream<int> increaseScore;
  final Stream<int> reduceScore;

  FinderScoreText({@required this.increaseScore, @required this.reduceScore, @required Key key}): super(key : key);

  @override
  _FinderScoreTextState createState() => new _FinderScoreTextState();
}

class _FinderScoreTextState extends State<FinderScoreText> with FinderScoreTextView{

  FinderScoreTextPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FinderScoreTextPresenter(widget.increaseScore, widget.reduceScore)
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Score: "+presenter.totalScore.toString(),
      style: Theme.of(context).textTheme.display3.apply(
        color: Colors.white
      ),
      textAlign: TextAlign.right,
      maxLines: 1,
    );
  }

  @override
  void notifyState() {
    super.notifyState();
    if(mounted){
      setState(() {
        
      });
    }
  }

}