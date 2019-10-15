import 'package:findpairs/PresenterViews/Components/Buttons/PauseActionButtonView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class PauseActionButtonPresenter extends BaseComponentPresenter{

  PauseActionButtonView _view;

  PauseActionButtonView get view => _view;

  set setView(PauseActionButtonView vw){
    _view = vw;
  }

  @override
  void initiateData() {
    super.initiateData();
  }

  onIconHasTapped(){
    view.animationController.forward();
  }
}