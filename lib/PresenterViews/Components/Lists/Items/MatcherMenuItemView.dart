import 'package:findpairs/Widgets/Pages/SurvivalPage.dart';
import 'package:flutter/Material.dart';
import 'package:navigatorium/navigatorium.dart';

class MatcherMenuItemView{

  double getHeight(){
    return MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + 180);
  }

  BuildContext currentContext(){
    return null;
  }

  Future<void> openMatcherPage(bool isFirstPlay) async{
    return Navigatorium.instance.push(
      currentContext(),
      child: SurvivalPage(
        isFirstPlay: isFirstPlay,
      )
    );
  }

  void notifyState(){}
}