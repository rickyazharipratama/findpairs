import 'dart:math';

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
}