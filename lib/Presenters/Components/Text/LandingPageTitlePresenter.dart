import 'package:findpairs/PresenterViews/Components/Text/LandingPageTitleView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class LandingPageTitlePresenter extends BaseComponentPresenter{

  LandingPageTitleView _view;
  Stream<Map<String,dynamic>> _stream;
  Map<String,dynamic> _title;

  LandingPageTitlePresenter(Stream str){
    _stream = str;
    _stream.listen(onReceiveSinker);
  }

  LandingPageTitleView get view => _view;
  set setView(LandingPageTitleView vw){
    _view = vw;
  }

  Map<String,dynamic> get title => _title;
  set setTitle(Map<String,dynamic> ttl){
    _title = ttl;
  }

  onReceiveSinker(Map<String,dynamic> data){
    setTitle = data;
    view.notifyState();
  }
}