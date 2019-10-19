class ArcadeCardValue{

  String _value;
  int key;
  bool _isAlreadySelected = false;
  bool _isAlreadyPaired = false;

  String get value => _value;
  bool get  isAlreadySelected => _isAlreadySelected;
  bool get isAlreadyPaired => _isAlreadyPaired;

  set setValue(String val){_value = value;}
  set setAlreadySelected(bool val){
    _isAlreadySelected = val;
  }
  set setAlreadyPaired(bool val){
    _isAlreadyPaired = val;
  }

  ArcadeCardValue(int key,String val){
    _value = val;
  }
}