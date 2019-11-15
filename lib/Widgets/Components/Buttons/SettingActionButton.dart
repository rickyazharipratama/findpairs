import 'package:findpairs/PresenterViews/Components/Buttons/SettingActionButtonView.dart';
import 'package:findpairs/Presenters/Components/Buttons/SettingActionButtonPresenter.dart';
import 'package:flutter/material.dart';

class SettingActionButton extends StatefulWidget {
  final Color color;

  SettingActionButton({this.color : const Color(0xffe6e7e9)});

  @override
  _SettingActionButtonState createState() => new _SettingActionButtonState();
}

class _SettingActionButtonState extends State<SettingActionButton> with SingleTickerProviderStateMixin,SettingActionButtonView{

  SettingActionButtonPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    setAnim = animController;
    presenter = SettingActionButtonPresenter()..setView = this;
    presenter.initiateData(); 
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: presenter.onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Transform.rotate(
          angle: getAnimatedAngle(),
          child: Icon(
            Icons.settings,
            color: widget.color,
            size: 40,
          ),
        ),
      ),
    );
  }

  @override
  BuildContext currentContext() => context;

  @override
  void notifyState() {
    super.notifyState();
    if(mounted){
      setState(() {
        
      });
    }
  } 

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }
}