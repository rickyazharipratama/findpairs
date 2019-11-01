import 'package:findpairs/PresenterViews/Components/Text/FInderCorrectRatioTextView.dart';
import 'package:findpairs/Presenters/Components/Text/FinderCorrectRatioTextPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:flutter/material.dart';

class FinderCorrectRatioText extends StatefulWidget {

  final Stream<double> updateRatio;

  FinderCorrectRatioText({@required this.updateRatio});

  @override
  _FinderCorrectRatioTextState createState() => new _FinderCorrectRatioTextState();
}

class _FinderCorrectRatioTextState extends State<FinderCorrectRatioText> with FinderCorrectRatioTextView{

  FinderCorrectRatioTextPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = FinderCorrectRatioTextPresenter(
      updateRatio: widget.updateRatio
    )
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Correct Ratio: "+ CommonUtil.instance.fixedNumberFormat(presenter.ratio * 100)+"%",
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