import 'dart:async';

import 'package:findpairs/Models/SurvivalScore.dart';
import 'package:findpairs/PresenterViews/Components/Lists/Items/MatcherMenuItemView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatcherMenuItemPresenter extends BaseComponentPresenter{
  
  MatcherMenuItemView _view;
  SurvivalScore score;
  bool _isNeedShowScore = false;
  final StreamSink<bool> notifyReactiveSink;

  MatcherMenuItemView get view => _view;
  set setView(MatcherMenuItemView vw){
    _view = vw;
  }

  bool get isNeedShowScore => _isNeedShowScore;
  set setNeedShowScore(bool isVal){
    _isNeedShowScore = isVal;
  }

  MatcherMenuItemPresenter({this.notifyReactiveSink}){
    score = SurvivalScore();
  }

  @override
  void initiateData() async{
    await score.getFromStore();
    if(score.score > 0){
      setNeedShowScore = true;
      view.notifyState();
    }
  }

  openingMatcherPage() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool fls = pref.getBool(ConstantCollections.PREF_MATCHER_TUTORIAL);
    await view.openMatcherPage(fls);
    notifyReactiveSink.add(true);
    score.getFromStore();
    view.notifyState();
  }
}