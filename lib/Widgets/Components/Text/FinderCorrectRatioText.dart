import 'package:findpairs/PresenterViews/Components/Text/FInderCorrectRatioTextView.dart';
import 'package:findpairs/Presenters/Components/Text/FinderCorrectRatioTextPresenter.dart';
import 'package:flutter/material.dart';

class FinderCorrectRatioText extends StatefulWidget {
  @override
  _FinderCorrectRatioTextState createState() => new _FinderCorrectRatioTextState();
}

class _FinderCorrectRatioTextState extends State<FinderCorrectRatioText> with FinderCorrectRatioTextView{

  FinderCorrectRatioTextPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FinderCorrectRatioTextPresenter()
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Correct Ratio: "+presenter.ratio.toString()+"%",
      style: Theme.of(context).textTheme.display3.apply(
        color: Colors.white
      ),
      textAlign: TextAlign.right,
      maxLines: 1,
    );
  }
}