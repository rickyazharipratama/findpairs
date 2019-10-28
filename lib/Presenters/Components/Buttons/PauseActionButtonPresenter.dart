import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Buttons/PauseActionButtonView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';

class PauseActionButtonPresenter extends BaseComponentPresenter{

  PauseActionButtonView _view;

  StreamSink<GamePauseType> pauseSinker;

  PauseActionButtonView get view => _view;

  set setView(PauseActionButtonView vw){
    _view = vw;
  }

  PauseActionButtonPresenter(StreamSink<GamePauseType>sinker){
    pauseSinker = sinker;
  }

  @override
  void initiateData() {
    super.initiateData();
  }

  onIconHasTapped() async{
    view.animationController.forward();
    pauseSinker.add(GamePauseType.onGamePause);
    GamePauseType type = await view.openPauseMenu();
    pauseSinker.add(type);
  }
}