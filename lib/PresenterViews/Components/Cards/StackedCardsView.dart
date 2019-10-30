import 'package:flutter/widgets.dart';

class StackedCardsView{

  double get cardHeight => (MediaQuery.of(currentContext()).size.height - (MediaQuery.of(currentContext()).padding.top + MediaQuery.of(currentContext()).padding.bottom)) * 0.2;

  double get cardWidth => (cardHeight * 9) / 13;

  BuildContext currentContext() => null;

}