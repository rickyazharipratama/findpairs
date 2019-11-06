import 'package:findpairs/PresenterViews/Components/Cards/Items/SurvivalFrontCardView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class SurvivalFrontCardPresenter extends BaseComponentPresenter{

  final Stream<bool> shouldAnimatedStream;

  SurvivalFrontCardView _view;
  int _val;

  SurvivalFrontCardView get view => _view;
  set setView(SurvivalFrontCardView vw){
    _view = vw;
  }

  int get val => _val;
  set setVal(int vl){
    _val = vl;
  }

  SurvivalFrontCardPresenter({int value, this.shouldAnimatedStream}){
    _val = value;
    shouldAnimatedStream.listen(onListenAnimatedStream);
  }

  
  onListenAnimatedStream(bool isVal){
    if(isVal){
      view.animationController.forward(from: 0);
    }
  }

  void dispose(){
    view.animationController.dispose();
  }
}