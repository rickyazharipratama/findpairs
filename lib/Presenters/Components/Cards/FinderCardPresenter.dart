import 'dart:convert';

import 'package:findpairs/Models/FinderCardFormation.dart';
import 'package:findpairs/Models/FinderSumaryScore.dart';
import 'package:findpairs/PresenterViews/Components/Cards/FinderCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/services.dart';

class FinderCardPresenter extends BaseComponentPresenter{

  FinderCardView _view;
  FinderCardFormation _finderAssets;
  FinderSumaryScore _summary;

  FinderCardPresenter(){
    _summary = FinderSumaryScore();
  }

  FinderCardView get view => _view;
  set setView(FinderCardView vw){
    _view = vw;
  }

  FinderCardFormation get finderAssets => _finderAssets;
  set setFinderAsset(List<dynamic> data){
    _finderAssets = FinderCardFormation.fromJson(data);
  }

  @override
  void initiateData()async{
    super.initiateData();
    await _summary.getScoreFromStore();
    await configureFormation();
    view.notifyState();
  }

  configureFormation() async{
    _finderAssets = FinderCardFormation.fromJsonAndScore(jsonDecode(await rootBundle.loadString("assets/json/Finder.json")), _summary.score);
  }
}