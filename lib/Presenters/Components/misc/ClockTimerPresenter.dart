import 'dart:async';

import 'package:findpairs/PresenterViews/Components/misc/ClockTImerView.dart';
import 'package:findpairs/Presenters/Components/BaseComponentPresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';

class CLockTimerPresenter extends BaseComponentPresenter{

  ClockTimerView _view;
  int _countDown;
  int _critTime;
  StreamSink<ArcadeTimer> _sinker;
  Stream<ArcadeTimer>_stream;

  ClockTimerView get view => _view;
  set setView(ClockTimerView vw){
    _view = vw;
  }

  int get countDown => _countDown;
  set setCountDown(int val){
    _countDown = val;
  }

  StreamSink<ArcadeTimer> get sinker => _sinker;
  set setSinker(StreamSink<ArcadeTimer> sink){
    _sinker = sink;
  }

  Timer timer;
  
  CLockTimerPresenter(int timer, int critTime,StreamSink<ArcadeTimer> sink, Stream<ArcadeTimer> stream){
    _countDown = timer;
    _critTime = critTime;
    setSinker = sink;
    _stream = stream;
    _stream.listen(onStreamListen);
  }

  @override
  initiateData(){
    int lastTimer = DateTime.now().millisecondsSinceEpoch;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (tm){
       int curr = DateTime.now().millisecondsSinceEpoch;
       int diff = curr - lastTimer;
       lastTimer = curr;
       setCountDown = countDown -  (diff / 1000).round();
       if(countDown  == _critTime){
         _sinker.add(ArcadeTimer.onAlmostTimeUp);
         view.animationController.forward();
       }else if(countDown == 0){
         timer.cancel();
         _sinker.add(ArcadeTimer.onTimeUp);
       }
       view.notifyState();
    });
  }

  onStreamListen(ArcadeTimer type){
    if(type == ArcadeTimer.onTimeMustStop){
      timer.cancel();
    }
  }

  dispose(){
    timer.cancel();
    view.animationController.dispose();
  }
}