import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/PresenterViews/Components/Buttons/SettingActionButtonView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class SettingActionButtonPresenter extends BaseComponentPresenter{

  SettingActionButtonView _view;

  SettingActionButtonView get view => _view;
  set setView(SettingActionButtonView vw){
    _view = vw;
  }

  @override
  void initiateData() {
    super.initiateData();


  }

  onTap(){
    playSFXComponent();
    view.animController.forward();
  }

  @override
  void playSFXComponent(){
    FindPairsApp.of(view.currentContext()).presenter.sfxSound.play("button_tap.mp3");
  }
}