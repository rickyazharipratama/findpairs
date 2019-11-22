import 'dart:math';

import 'package:findpairs/Utils/ConstantCollections.dart';

class CommonUtil{

  static CommonUtil instance =  CommonUtil();

  double getRatio(List<int> val, List<int> reference){
    
    int countPaired = 0;
    val.forEach((vl){
      if(reference.contains(val)){
        countPaired++;
      }
    });
    return countPaired / reference.length;
  }

  String fixedNumberFormat(double val){
    List<String> strForm = val.toString().split(".");
    return strForm[0];
  }

  int getUniqueRandom({int max,List<int> reference}){
    Random random = Random();
    int rand = random.nextInt(max);
    while(reference.contains(rand)){
      rand = random.nextInt(max);
    }
    return rand;
  }

  String decimalFormat(double val){
    List<String> source = val.toString().split(".");
    String overPoint = "00";
    if(source.length > 1){
      if(source[1].length >= 2){
        overPoint = source[1].substring(0,2);
      }else{
        overPoint = source[1]+"0";
      }
    }
    return source[0]+"."+overPoint;
  }

  String formatScore(int score){
    if(score >= 1000000000000){
      return  decimalFormat(score / 1000000000000)+" T";
    }else if(score >= 1000000000){
      return decimalFormat(score / 1000000000)+" B";
    }else if(score >= 1000000){
      return decimalFormat(score / 1000000)+" M";
    }else if(score >= 1000){
      return decimalFormat(score / 1000)+" K";
    }else{
      return score.toString();
    }
  } 


  void showLog({String log}){
    if(ConstantCollections.ENVIRONMENT == ConstantCollections.DEVELOPMENT){
      print(log);
    }
  }
}