import 'package:flutter/material.dart';

class SurvivalBottomPlacedView{

  double wrapperHeight(double cardHeight){
    return cardHeight + 10 + MediaQuery.of(currentContext()).padding.bottom;
  }


  BuildContext currentContext() => null;

  void noitfyState(){}
}