import 'package:findpairs/PresenterViews/Components/Buttons/ArcadeSoundButtonView.dart';
import 'package:findpairs/Presenters/Components/Buttons/ArcadeSoundButtonPresenter.dart';
import 'package:flutter/material.dart';

class ArcadeSoundButton extends StatefulWidget {
  @override
  _ArcadeSoundButtonState createState() => new _ArcadeSoundButtonState();
}

class _ArcadeSoundButtonState extends State<ArcadeSoundButton> with SingleTickerProviderStateMixin,ArcadeSoundButtonView{

  ArcadeSoundButtonPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = ArcadeSoundButtonPresenter()..setView = this..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Expanded(
            child: Text(
              "SOUND",
              style: Theme.of(context).textTheme.display4..apply(
                color: Colors.black
              ),
            ),
          ),
          
          GestureDetector(
            onTap: presenter.settingSound,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xffe8e8ef),
                border: Border.all(
                  color: Color(0xffdadadf),
                  width: 2
                ),
              ),
              child: Center(
                child: Icon(
                  presenter.soundControl.isSilentMode ? Icons.volume_off : Icons.volume_up,
                  size: 25,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void notifyState(){
    if(mounted){
      setState(() {
        
      });
    }
  }

  @override
  BuildContext currentContext() => context;

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

}