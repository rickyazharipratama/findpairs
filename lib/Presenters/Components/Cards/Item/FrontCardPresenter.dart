import 'package:findpairs/Models/ArcadeCardValue.dart';
import 'package:findpairs/PresenterViews/Components/Cards/Items/FrontCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class FrontCardPresenter extends BaseComponentPresenter{

  FrontCardView _view;
  ArcadeCardValue _value;
  Stream<int> _paired;

  FrontCardPresenter(Stream<int> stream, ArcadeCardValue val){
    _paired = stream;
    _value = val;
    _paired.listen(listenPaired);
  }

  set setView(FrontCardView vw){
    _view = vw;
  }
  FrontCardView get view => _view;

  set setvalue(ArcadeCardValue val){
    _value = val;
  }

  ArcadeCardValue get value => _value;

  listenPaired(int val){
    if(value.key == val){
      print("firework on");
    }
  }
}