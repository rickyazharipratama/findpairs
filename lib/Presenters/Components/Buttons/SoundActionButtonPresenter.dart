import 'package:findpairs/Models/SoundModel.dart';
import 'package:findpairs/PresenterViews/Components/Buttons/SoundActionButtonView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/animation.dart';

class SoundActionButtonPresenter extends BaseComponentPresenter{

  SoundActionButtonView _view;
  bool isAcceptAction = true;
  SoundModel soundControl;
  final Stream<bool> notifyReactiveStream;

  SoundActionButtonPresenter({this.notifyReactiveStream }){
    soundControl = SoundModel();
    notifyReactiveStream.listen(listenReactiveStream);
  }

  SoundActionButtonView get view => _view;
  set setView(SoundActionButtonView vw){
    _view = vw;
  }

  listenReactiveStream(bool isVal) async{
    print("called by sink");
    bool oldVal = soundControl.isSilentMode;
    await soundControl.getValueFromPreference();
    if(oldVal != soundControl.isSilentMode){
      if(soundControl.isSilentMode){
        muteTheVoice();
      }else{
        bringBackSound();
      }
    }
  }
  
  @override
  void initiateData() async{
    super.initiateData();
    view.animationController.addStatusListener(listenAnimationStatus);
    await soundControl.getValueFromPreference();
    if(soundControl.isSilentMode){
      muteTheVoice();
    }
  }


  muteTheVoice(){
    isAcceptAction = false;
    soundControl.setSilentMode = true;
    soundControl.setValueToPreference();
    view.animationController.forward();
  }

  bringBackSound(){
    isAcceptAction = false;
    soundControl.setSilentMode = false;
    soundControl.setValueToPreference();
    view.animationController.reverse();
  }

  listenAnimationStatus(AnimationStatus status){
    if(status == AnimationStatus.completed || status == AnimationStatus.dismissed){
      isAcceptAction = true;
      view.notifyState();
    }
  }

  void dispose(){
    view.animationController.dispose();
  }
}