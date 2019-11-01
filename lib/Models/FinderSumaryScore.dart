import 'package:findpairs/Utils/ConstantCollections.dart';
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
      setLife = tmp;
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
    //checkpoint for playing before
    await getLifeFromStore();
    if(life == 0){
       await getScoreFromStore();
      //must have some logic to set life based on score
      setLife = 3;
    }
  }
}