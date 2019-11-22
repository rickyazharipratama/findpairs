import 'package:findpairs/PresenterViews/Components/Cards/SurvivalBottomPlacedView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';

class SurvivalBottomPlacedPresenter extends BaseComponentPresenter{

  final Stream<bool> isCardCorrectStream;
  SurvivalBottomPlacedView _view;

  set setView(SurvivalBottomPlacedView vw){
    _view = vw;
  }
  SurvivalBottomPlacedView get view => _view;

  SurvivalBottomPlacedPresenter({
    this.isCardCorrectStream
  }){
    isCardCorrectStream.listen(listenIsCardCorrect);
  }

  @override
  void initiateData() {
    super.initiateData();
  }

  listenIsCardCorrect(bool val){
    CommonUtil.instance.showLog(log:"card correct : "+val.toString());
    if(val){
      view.setRightAnimation();
    }else{
      view.setWrongAnimation();
    }
    view.animationController.forward();
  }


  void dispose(){
    view.animationController.dispose();
  }
}