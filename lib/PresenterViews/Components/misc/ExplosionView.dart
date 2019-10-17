import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class ExplosionView{

  AnimationController _animationController;
  Animation _animation;
  Size _imageSize;

  GlobalKey _globalKey;
  
  AnimationController get animationController => _animationController;
  Animation get animation => _animation;

  set setAnimationController(TickerProvider tick){
    _animationController = AnimationController(
      vsync: tick,
      duration: const Duration(milliseconds: 450)
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _animationController
      )
    );
  }

  GlobalKey get globalKey => _globalKey;
  set setGLobalKey(String tag){
    _globalKey = GlobalObjectKey(tag);
  }

  Size get imageSize => _imageSize;
  set setImageSize( Size val){
    _imageSize = val;
  }

  void notifyState(){}

}