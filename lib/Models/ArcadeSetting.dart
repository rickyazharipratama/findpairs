class ArcadeSetting{
  int _vertical;
  int _horizontal;
  int _uniqueCard;
  int _life;
  int _time;
  int _critTime;
  List<FormationArcadeSetting> _formations;

  List<FormationArcadeSetting> get formations => _formations;
  int get uniqueCard => _uniqueCard;
  int get horizontal => _horizontal;
  int get vertical => _vertical;
  int get time => _time;
  int get life => _life;
  int get critTime => _critTime;

  ArcadeSetting(Map<String,dynamic> data){
    _vertical = data['vertical'];
    _horizontal = data['horizontal'];
    _uniqueCard = data['uniqueCard'];
    _life = data['life'];
    _time = data['time'];
    _critTime = data['critTime'];
    _formations = List();
    for(Map<String,dynamic> formation in data['formations'] as List<dynamic>){
      _formations.add(FormationArcadeSetting.fromMap(formation));
    }
  }

  set setLife(int currentLife){
    _life = currentLife;
  }

  set setTime(int tm){
    _time = tm;
  }
}

class FormationArcadeSetting{
  int _row;

  int get row => _row;

  FormationArcadeSetting.fromMap(Map<String,dynamic> data){
    _row = int.parse(data['row'].toString()); 
  }
}