import 'dart:async';

import 'package:findpairs/Models/ArcadeLogPlayer.dart';
import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeMenuItemView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';

class ArcadeMenuItemPeresenter extends BaseComponentPresenter{


  ArcadeMenuItemView _view;
  bool _isNeedAdvancedMenu = false;
  final StreamSink<bool> notifyReactiveSink;

  ArcadeMenuItemPeresenter({this.notifyReactiveSink});

  set setNeedAdvancedMenu(bool val){
    _isNeedAdvancedMenu = val;
  }

  bool get isNeedAdvancedMenu => _isNeedAdvancedMenu;

  ArcadeMenuItemView get view => _view;
  set setView(ArcadeMenuItemView vw){
    _view = vw;
  }

  void continueArcade() async{
    //should spawning   stage selection
    setNeedAdvancedMenu = false;
    await view.goToSelectionStage();
    notifyReactiveSink.add(true);
    view.notifyState();
  }


  void checkingStages()async {
    CommonUtil.instance.showLog(log:"checking stages");
    ArcadeLogPlayer log = ArcadeLogPlayer();
    await log.retrieveData();
    if(log.episodes == null){
      initiateArcade();
    }else{
      setNeedAdvancedMenu = true;
      view.controller.forward(from: 0);
    }
  }

  initiateArcade() async{
    CommonUtil.instance.showLog(log:"initiate Stage");
    ArcadeLogPlayer log = ArcadeLogPlayer.initialize();
    log.episodes[0].logs[0].setLocked = false;
    log.savingToPreference();
    await view.gotoStage(log.episodes[0].episode, log.episodes[0].logs[0].stage);
    notifyReactiveSink.add(true);
    if(isNeedAdvancedMenu){
      setNeedAdvancedMenu = false;
      view.notifyState();
    }
  }

  void dispose(){
    view.controller.dispose();
  }
}