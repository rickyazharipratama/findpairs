
import 'package:findpairs/PresenterViews/Components/misc/ExplosionView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ExplosionPresenter extends BaseComponentPresenter{

  ExplosionView _view;
  String _tag;
  ByteData _byteData;
  Stream<bool> _explodeStream;
  

  ExplosionView get view => _view;
  set setView(ExplosionView vw){
    _view = vw;
  }

  ByteData get byteData => _byteData;
  set setByteData(ByteData bd){
    _byteData = bd;
  }

  String get tag => _tag;
  set setTag(String tg){
    _tag = tg;
  }
  
  ExplosionPresenter(String tg, Stream<bool> stream){
    setTag = tg;
    _explodeStream = stream;
    _explodeStream.listen(onListenStream);
  }

  @override
  void initiateData() {
    super.initiateData();
  }

  onListenStream(bool isVal){
    if(isVal){
      print("explosion count");
      if(byteData == null || view.imageSize == null){
        RenderRepaintBoundary boundary = view.globalKey.currentContext.findRenderObject();
        boundary.toImage().then((img){
          view.setImageSize = Size(img.width.toDouble(), img.height.toDouble());
          img.toByteData().then((bd){
            setByteData = bd;
            view.animationController.value = 0;
            view.animationController.forward();
            view.notifyState();
          });
        });
      }else{
        view.animationController.value = 0;
        view.animationController.forward();
        view.notifyState();
      }
    }
  }


  dispose(){
    view.animationController.dispose();
  } 
}