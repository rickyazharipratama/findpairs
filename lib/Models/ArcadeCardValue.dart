class ArcadeCardValue{

  String _value;
  bool _isAlreadySelected = false;

  String get value => _value;
  bool get  isAlreadySelected => _isAlreadySelected;

  set setValue(String val){_value = value;}
  set setAlreadySelected(bool val){
    _isAlreadySelected = val;
  }

  ArcadeCardValue(String val){
    _value = val;
  }
}