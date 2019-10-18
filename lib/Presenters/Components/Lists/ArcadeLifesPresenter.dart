import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/ArcadeLifesView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';

class ArcadeLifesPresenter extends BaseComponentPresenter{

  ArcadeLifesView _view;
  int _initialCounter;
  List<int> _lifes;
  int _extendedlifes = 0;
  Stream<bool> _lifeLostListener;

  StreamController<bool>_extendedControl = StreamController();
  StreamController<int>_extendedLifeStreamControl = StreamController();
  StreamController<int> _lifeStreamControl = StreamController.broadcast();

  StreamSink<bool> get extendedDispose => _extendedControl.sink;
  Stream<int> get streamExtendeLife => _extendedLifeStreamControl.stream;

  Stream<int> get lifeStream => _lifeStreamControl.stream;


  ArcadeLifesView get view => _view;
  set setView(ArcadeLifesView vw){
    _view = vw;
  }

  int get extendedLifes => _extendedlifes;
  set setExtendedLifes(int val){
    _extendedlifes = val;
  }

  List<int> get lifes => _lifes;

  set setInitialCounter(int val){
    _initialCounter = val;
  }

  ArcadeLifesPresenter(Stream<bool> stream, int life){
    _lifeLostListener = stream;
    _lifeLostListener.listen(onLifeLost);
    _initialCounter = life;
  }

  @override
  initiateData(){
    int right = 0;
    _extendedlifes = 0;
    if(_lifes == null){
      _lifes = List();
    }else{
      _lifes.clear();
    }
    for(int i = 0; i < _initialCounter; i++){
      _lifes.add(right);
      if(i > 4){
        _extendedlifes++;
      }
      right+=15;
    }
    if(extendedLifes > 0){
      _extendedControl.stream.listen(onExtendedDispose);
    }
    view.notifyState();
  }

  onLifeLost(bool val){
    //should animate with lifelost
    if(val){
      int tg = lifes[lifes.length - 1];
      lifes.removeLast();
      if(extendedLifes > 0){
        setExtendedLifes = extendedLifes - 1;
        _extendedLifeStreamControl.sink.add(extendedLifes);
      }else{
        //should dispose heart;
        _lifeStreamControl.sink.add(tg);
        Timer(const Duration(milliseconds: 600),(){
          view.notifyState();
        });
      }
    }
  }

  onExtendedDispose(bool val){
    if(val){
      view.notifyState();
    }
  }

  dispose(){
    _extendedLifeStreamControl.close();
    _extendedControl.close();
    _lifeStreamControl.close();
  }
}