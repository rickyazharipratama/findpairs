import 'package:findpairs/Models/DetailFinderCardFormation.dart';

class FinderCardFormation{
  

  List<DetailFinderCardFormation> finderCardFormations;

  DetailFinderCardFormation _currentCardFormation;


  FinderCardFormation.fromJson(List<dynamic> data){
    finderCardFormations = List();
    for(Map<String,dynamic> formation in data){
      finderCardFormations.add(DetailFinderCardFormation.fromJson(formation));
    }
  }

  FinderCardFormation.fromJsonAndScore(List<dynamic> data, int score){
    finderCardFormations = List();
    for(Map<String,dynamic> formation in data){
      finderCardFormations.add(DetailFinderCardFormation.fromJson(formation));
    }
    setCurrentFormationByScore(score);
  }

  DetailFinderCardFormation get currentCardFormation => _currentCardFormation;
  
  setCurrentFormationByScore(int score){
    _currentCardFormation = finderCardFormations.lastWhere((formation)=> formation.minScore <= score);
  }
}