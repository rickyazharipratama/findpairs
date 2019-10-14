class ArcadeSetting{
  int _vertical;
  int _horizontal;
  int _uniqueCard;
  List<FormationArcadeSetting> _formations;

  List<FormationArcadeSetting> get formations => _formations;
  int get uniqueCard => _uniqueCard;
  int get horizontal => _horizontal;
  int get vertical => _vertical;

  ArcadeSetting(Map<String,dynamic> data){
    _vertical = data['vertical'];
    _horizontal = data['horizontal'];
    _uniqueCard = data['uniqueCard'];
    _formations = List();
    for(Map<String,dynamic> formation in data['formations'] as List<dynamic>){
      _formations.add(FormationArcadeSetting.fromMap(formation));
    }
  }
}

class FormationArcadeSetting{
  int _row;

  int get row => _row;

  FormationArcadeSetting.fromMap(Map<String,dynamic> data){
    _row = int.parse(data['row'].toString()); 
  }
}