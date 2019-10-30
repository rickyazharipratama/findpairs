import 'package:flutter/material.dart';

class FinderPageView{


  double get stackedHeight{
    return (MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom)) * 0.2;
  }

  BuildContext currentContext() => null;
}