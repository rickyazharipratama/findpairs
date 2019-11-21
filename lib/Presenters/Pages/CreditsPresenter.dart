import 'package:findpairs/PresenterViews/Pages/CreditsView.dart';
import 'package:findpairs/Presenters/Pages/BasePagePresenter.dart';

class CreditsPresenter extends BasePagePresenter{

  CreditsView _view;

  CreditsView get view => _view;
  set setView(CreditsView vw){
    _view = vw;
  }

  @override
  void initiateData() {
    super.initiateData();
  }
}