import 'package:findpairs/PresenterViews/Components/Cards/Items/FinderFlipCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class FinderFlipCardPresenter extends BaseComponentPresenter{

  FinderFlipCardView _view;

  FinderFlipCardPresenter();

  @override
  initiateData(){

  }

  FinderFlipCardView get view => _view;
  set setView(FinderFlipCardView vw){
    _view = vw;
  }
}