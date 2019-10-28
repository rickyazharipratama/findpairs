import 'package:findpairs/PresenterViews/Modals/PauseMenuModalView.dart';
import 'package:findpairs/Presenters/Modals/PauseMenuModalPresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Components/Buttons/ArcadeItemMenuButton.dart';
import 'package:findpairs/Widgets/Components/Buttons/ArcadeSoundButton.dart';
import 'package:flutter/material.dart';

class PauseMenuModal extends StatefulWidget {
  @override
  _PauseMenuModalState createState() => new _PauseMenuModalState();
}

class _PauseMenuModalState extends State<PauseMenuModal> with SingleTickerProviderStateMixin,PauseMenuModalView{

  PauseMenuModalPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = PauseMenuModalPresenter()..setView = this..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: animation.value,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xeef9f9f9),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,   
            children: <Widget>[

              ArcadeItemMenuButton(
                color: Colors.black,
                title: "RESUME",
                onTap: (){
                  Navigator.of(context).pop(GamePauseType.onGameresume);
                },
              ),

              ArcadeSoundButton(),

              ArcadeItemMenuButton(
                color: Colors.black,
                title: "EXIT",
                onTap: (){
                  Navigator.of(context).pop(GamePauseType.onGameExit);
                },
              )

            ],
          ),
        ),
      ),
    );
  }

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