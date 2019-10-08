import 'package:findpairs/PresenterViews/FindPairsAppPresenterView.dart';
import 'package:findpairs/Presenters/BasePresenter.dart';

class FindPairsAppPresenter extends BasePresenter{

  FindPairsAppPresenterView _view;

  FindPairsAppPresenterView get view => _view;
  set setView(FindPairsAppPresenterView vw){
    _view = vw;
  }
}