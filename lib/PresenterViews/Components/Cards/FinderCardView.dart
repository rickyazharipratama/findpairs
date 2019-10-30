import 'package:flutter/cupertino.dart';

class FinderCardView{

  Size get cardSize{
    double width = (MediaQuery.of(currentContext()).size.width - 50) / 5;
    double stacked = (MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom)) * 0.2;
    double roomHeight = MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + stacked + 60);

    while((getCardHeight(width) + 10) * 5 > roomHeight){
      width -= 1;
    }
    return Size(width,getCardHeight(width));
  }

  double getCardHeight(double width) => (width * 13 ) / 9;

  BuildContext currentContext() => null;
  void notifyState(){}
}