import 'package:findpairs/PresenterViews/Modals/PauseMenuModalView.dart';
import 'package:findpairs/Presenters/BasePresenter.dart';

class PauseMenuModalPresenter extends BasePresenter{
  
  PauseMenuModalView _view;
  
  PauseMenuModalView get view => _view;
  set setView(PauseMenuModalView vw){
    _view = vw;
  }

  @override
  void initiateData() {
    super.initiateData();
    view.animationController.forward();
  }

  void dispose(){
    view.animationController.dispose();
  }
}