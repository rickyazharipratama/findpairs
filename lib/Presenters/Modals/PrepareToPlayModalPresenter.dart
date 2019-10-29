import 'package:findpairs/FindPairsApp.dart';
import 'package:findpairs/PresenterViews/Modals/PrepareToPlayView.dart';
import 'package:findpairs/Presenters/BasePresenter.dart';
import 'package:findpairs/Utils/SoundManager.dart';

class PrepareToPlayModalPresenter extends BasePresenter{

  PrepareToPlayView _view;



  PrepareToPlayView get view => _view;
  set setView(PrepareToPlayView vw){
    _view = vw;
  }

  @override
  void initiateData() async{
    super.initiateData();
    SoundManager.manager.play(
      player: FindPairsApp.of(view.currentContext()).presenter.particleSound,
      filename: "ready_arcade.mp3"
    );
    view.animationController.forward();
  }

  void dispose(){
    view.animationController?.dispose();
  }
}