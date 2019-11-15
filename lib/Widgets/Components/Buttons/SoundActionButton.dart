import 'package:findpairs/PresenterViews/Components/Buttons/SoundActionButtonView.dart';
import 'package:findpairs/Presenters/Components/Buttons/SoundActionButtonPresenter.dart';
import 'package:flutter/material.dart';

class SoundActionButton extends StatefulWidget {

  final Stream<bool> notifyReactiveStream;

  SoundActionButton({@required this.notifyReactiveStream});

  @override
  _SoundActionButtonState createState() => new _SoundActionButtonState();
}

class _SoundActionButtonState extends State<SoundActionButton> with SingleTickerProviderStateMixin, SoundActionButtonView{

  SoundActionButtonPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = SoundActionButtonPresenter(
      notifyReactiveStream: widget.notifyReactiveStream
    )
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: presenter.soundControl.isSilentMode ? presenter.bringBackSound : presenter.muteTheVoice,
      child: Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5
        ),
        margin: const EdgeInsets.only(
          right: 5
        ),
        child: Stack(
          children: <Widget>[
            
            Positioned.fill(
              child: Center(
                child: Icon(
                  Icons.volume_up,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),

            Positioned.fill(
              child: Center(
                child: Transform.rotate(
                  angle: 2.5,
                  child: Container(
                    width: 5,
                    height: animation.value,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  void notifyState(){
    if(mounted){
      setState(() {
        
      });
    }
  }

  @override
  dispose(){
    presenter.dispose();
    super.dispose();
  }

}