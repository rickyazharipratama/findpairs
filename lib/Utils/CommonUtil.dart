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
}