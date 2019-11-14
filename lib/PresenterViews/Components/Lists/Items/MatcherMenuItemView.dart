import 'package:findpairs/Widgets/Pages/SurvivalPage.dart';
import 'package:flutter/Material.dart';

class MatcherMenuItemView{

  double getHeight(){
    return MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + 180);
  }

  BuildContext currentContext(){
    return null;
  }

  void openMatcherPage(bool isFirstPlay){
    Navigator.of(currentContext()).push(MaterialPageRoute(
      builder: (context)=> SurvivalPage(
        isFirstPlay: isFirstPlay,
      )
    ));
  }

  void notifyState(){}
}