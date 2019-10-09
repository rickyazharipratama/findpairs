import 'package:flutter/cupertino.dart';

class LandingPageMenuItemView{

  double getHeight(){
    return MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom + 180);
  }

  BuildContext currentContext(){
    return null;
  }
}