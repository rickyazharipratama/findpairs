class ArcadeCardValue{

  String _value;
  int key;
  bool _isAlreadySelected = false;

  String get value => _value;
  bool get  isAlreadySelected => _isAlreadySelected;

  set setValue(String val){_value = value;}
  set setAlreadySelected(bool val){
    _isAlreadySelected = val;
  }

  ArcadeCardValue(int key,String val){
    _value = val;
  }
}