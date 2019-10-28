import 'package:findpairs/Models/SoundModel.dart';
import 'package:findpairs/PresenterViews/Components/Buttons/ArcadeSoundButtonView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class ArcadeSoundButtonPresenter extends BaseComponentPresenter{

  ArcadeSoundButtonView _view;
  SoundModel soundControl;

  ArcadeSoundButtonPresenter(){
    soundControl = SoundModel();
  }

  ArcadeSoundButtonView get view => _view;
  set setView(ArcadeSoundButtonView vw){
    _view = vw;
  }

  @override
  void initiateData() async{
    super.initiateData();
    await soundControl.getValueFromPreference();
    if(soundControl.isSilentMode == null){
      soundControl.setSilentMode = false;
      soundControl.setValueToPreference();
    }
    view.notifyState();
  }

  void settingSound() async{
    if(soundControl.isSilentMode){
      soundControl.setSilentMode = false;
    }else{
      soundControl.setSilentMode = true;
    }
    await soundControl.setValueToPreference();
    view.notifyState();
  }

  void dispose(){
    view.animationController.dispose();
  }
}