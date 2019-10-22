import 'package:findpairs/Models/ArcadeLogPlayer.dart';
import 'package:findpairs/PresenterViews/Pages/SelectArcadeStageView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';

class SelectArcadeStagePresenter extends BasePagePresenter{

  SelectArcadeStageView _view;
  String _episode;
  ArcadeLogPlayer _log;

  SelectArcadeStageView get view => _view;
  set setView(SelectArcadeStageView vw){
    _view = vw;
  }

  String get episode => _episode;
  set setEpisode(String ep){
    _episode = ep;
  }

  ArcadeLogPlayer get log => _log;

  @override
  void initiateData() async{
    super.initiateData();
    _log = ArcadeLogPlayer();
    await _log.retrieveData();
    view.notifyState();
  }
}