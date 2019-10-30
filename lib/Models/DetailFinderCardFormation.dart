class DetailFinderCardFormation{

  int minScore;
  int horizontal;
  int vertical;
  int total;
  double ratio;
  List<int> formations; 

  DetailFinderCardFormation.fromJson(Map<String,dynamic> data){
    minScore = data['minScore'];
    horizontal = data['horizontal'];
    vertical = data['vertical'];
    total = data['total'];
    ratio = double.parse(data['ratio'].toString());
    formations = List();
    for(Map<String,dynamic> form in data['formations'] as List<dynamic>){
      formations.add(form['rows']);
    }
  }
}