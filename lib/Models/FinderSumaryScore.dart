import 'dart:convert';

import 'package:findpairs/Models/FinderCardFormation.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinderSumaryScore{

  int _score = 0;
  double _ratio = 0;
  int _life = 0;
  int _totalMove = 0;
  int _totalCorrect = 0;

  int get totalMove => _totalMove;
  set setTotalMove(int val){
    _totalMove = val;
  }

  int get totalCorrect => _totalCorrect;
  set setTotalCorrect(int val){
    _totalCorrect = val;
  }

  int get score => _score;
  set setScore(int val){
    _score = val;
  }

  double get ratio => _ratio;
  set setRatio(double val){
    _ratio = val;
  }

  void updateRatio() async{
    setRatio = totalCorrect / totalMove;
    await setRatioToStore();
  }

  int get life => _life;
  set setLife(int val){
    _life = val;
  }

  getScoreFromStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    int tmp = pref.getInt(ConstantCollections.PREF_FINDER_SCORE);
    if(tmp != null){
      setScore = tmp;
    }
  }

  setScoreToStore()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(ConstantCollections.PREF_FINDER_SCORE, score);
  }

  getLifeFromStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    int tmp = pref.getInt(ConstantCollections.PREF_FINDER_LIFE);
    if(tmp  != null){
      if(tmp == 0){
        await reconfigureLife();
      }else{
        setLife = tmp;
      }
    }else{
      await reconfigureLife();
    }
  }

  setLifeToStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(ConstantCollections.PREF_FINDER_LIFE, life);
  }

  getRatioFromStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    double tmp = pref.getDouble(ConstantCollections.PREF_FINDER_RATIO);
    if(tmp != null){
      setRatio = tmp;
    }
  }

  setRatioToStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble(ConstantCollections.PREF_FINDER_RATIO, ratio);
  }

  getTotalMoveFromStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    int tmp = pref.getInt(ConstantCollections.PREF_FINDER_TOTAL_MOVE);
    if(tmp != null){
      setTotalMove = tmp;
    }
  }

  setTotalMoveToStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(ConstantCollections.PREF_FINDER_TOTAL_MOVE, totalMove);
  }

  getCorrectMoveFromStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    int tmp = pref.getInt(ConstantCollections.PREF_FINDER_CORRECT_MOVE);
    if(tmp != null){
      setTotalCorrect = tmp;
    }
  }

  setCorrectMoveToStore() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(ConstantCollections.PREF_FINDER_CORRECT_MOVE, totalCorrect);
  }

  reconfigureLife() async{
    await getScoreFromStore();
    FinderCardFormation form = FinderCardFormation.fromJsonAndScore(jsonDecode(await rootBundle.loadString("assets/json/Finder.json")), score);

    setLife = form.currentCardFormation.life;
    setLifeToStore();
  }
}