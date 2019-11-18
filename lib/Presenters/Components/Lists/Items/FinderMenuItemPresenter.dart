import 'dart:async';

import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Lists/Items/FinderMenuItemView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class FinderMenuItemPresenter extends BaseComponentPresenter{

  bool _isNeedAdvancedMenu = false;
  FinderMenuItemView _view;
  FinderSumaryScore score;
  final StreamSink<bool> notifyReactiveSink;

  FinderMenuItemPresenter({this.notifyReactiveSink}){
    score = FinderSumaryScore();
  }

  FinderMenuItemView get view => _view;
  set setView(FinderMenuItemView vw){
    _view = vw;
  }

  bool get isNeedAdvancedMenu => _isNeedAdvancedMenu;
  set setNeedAdvancedMenu( bool isVal){
    _isNeedAdvancedMenu = isVal;
  }

  @override
  void initiateData() async{
    super.initiateData();
  }

  void checkingFinder({bool isInfo: false}) async{
    await score.getTotalMoveFromStore();
    await score.getScoreFromStore();
    await score.getRatioFromStore();
    print("score : "+score.score.toString());
    if(score.totalMove > 0 || score.score > 0){
      setNeedAdvancedMenu = true;
      view.controller.forward(from: 0);
    }else{
      if(!isInfo){
        openingFinderPage();
      }
    }
  }

  void openingFinderPage() async{
     await view.openFinderStage();
      print("manggil ini");
      notifyReactiveSink.add(true);
      checkingFinder(isInfo: true);
  }

  void resetAllScore()async{
    await score.removeScoreFromStore();
    await score.removeLifeFromStore();
    await score.removeCorrectMoveFromStore();
    await score.removeRatioFromStore();
    await score.removeTotalMoveFromStore();
    print("check score : "+score.score.toString());
    openingFinderPage();
  }

  void dispose(){
    view.controller.dispose();
  }
}