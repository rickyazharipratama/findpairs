class DetailEpisodeArcadeLogPlayer{

    int _star = -1;
    double _score = -1;
    bool _isLocked = true;
    int stage;

    DetailEpisodeArcadeLogPlayer.initialize({this.stage});

    set setStar(int val){
      _star = val;
    }
    int get star => _star;

    set setScore(double val){
      _score = val;
    }

    double get score => _score;

    set setLocked(bool val){
      _isLocked = val;
    }

    bool get isLocked => _isLocked;

    DetailEpisodeArcadeLogPlayer.fromStore(Map<String,dynamic> data){
      _star = data['star'] != null ? int.parse(data['star'].toString()) : -1;
      _score = data['score'] != null ?  double.parse(data['score'].toString()) : -1;
      _isLocked = data['isLocked'];
      stage = int.parse(data['stage'].toString());
    }

    Map<String,dynamic> getMap(){
      return {  
        "star":_star,
        "isLocked":_isLocked,
        "score":_score,
        "stage":stage,
      };
    }

}