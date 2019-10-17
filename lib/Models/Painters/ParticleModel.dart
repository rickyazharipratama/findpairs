import 'dart:ui';
import 'dart:math';

import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/foundation.dart';

class ParticleModel{

  double _left;
  double _top;
  double _initialLeft;
  double _initialTop;
  double _sizeFactor;
  Color _color;
  ExplodeType _type;
  int _direction;
  double _topMax;
  double _leftMax;
  double _bottomMax;
  double _x;

  double get left => _left;
  set setLeft(double val){
    _left = val;
  }

  double get top => _top;
  set setTop(double val){
    _top = val;
  }

  double get initialLeft => _initialLeft;
  set setInitialLeft(double val){
    _initialLeft = val;
  }

  double get initialTop => _initialTop;
  set setInitialTop(double val){
    _initialTop = val;
  }

  double get sizeFactor => _sizeFactor;
  set setSizeFactor(double val){
    _sizeFactor = val;
  }

  Color get color => _color;
  set setColor(Color val){
    _color = val;
  }

  ExplodeType get type => _type;
  set setType(ExplodeType tp){
    _type = tp;
  }

  int get direction => _direction;
  set setDirection(int dir){
    _direction = dir;
  }

  double get topMax => _topMax;
  set setTopMax(double val){
    _topMax = val;
  }

  double get leftMax => _leftMax;
  set setLeftMax(double val){
    _leftMax = val;
  }

  double get bottomMax => _bottomMax;
  set setBottomMax(double val){
    _bottomMax = val;
  }

  double get x => _x;
  set setX(double val){
    _x = val;
  }

  ParticleModel({
    @required double left,
    @required double top,
    @required Color color,
    @required double sizeFactor,
    @required ExplodeType type
  }){
    setLeft = left;
    setTop = top;
    setColor = color;
    setSizeFactor = sizeFactor;
    setDirection = Random().nextBool() ? 1 : -1;
    setInitialLeft = left;
    setInitialTop = top;
    setX = Random().nextInt(1000)/1000;
    setLeftMax = direction == 1 ? (left  + 150 * x) : left - 200 * x;
    setTopMax = top - 150;
    setBottomMax = initialTop + 150;
    setType = type;
  }

  advance({@required double span, @required bool stage, @required double height}){
    if(type == ExplodeType.Spread){
      setLeft = initialLeft * ( 1 - span) + leftMax * span;
      setTop = initialTop + 50 * span + 100 * sin(pi/2 + 2 * span * pi); 
    }else{
      setTop = initialTop * (1 - span) + height * span;
    }
  }
}