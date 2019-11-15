import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeMenuItemView.dart';
import 'package:findpairs/Presenters/Components/Lists/Items/ArcadeMenuItemPresenter.dart';
import 'package:findpairs/Widgets/Components/Buttons/ArcadeItemMenuButton.dart';
import 'package:flutter/material.dart';

class ArcadeMenuItem extends StatefulWidget {

  final bool isActive;
  final Map<String,dynamic> menu;
  final double width;
  final double height;
  final StreamSink<bool> notifyReactiveSink;
  ArcadeMenuItem({this.isActive, this.menu, @required this.width, @required this.height, @required this.notifyReactiveSink});

  @override
  _ArcadeMenuItemState createState() => new _ArcadeMenuItemState();
}

class _ArcadeMenuItemState extends State<ArcadeMenuItem> with SingleTickerProviderStateMixin,ArcadeMenuItemView{

  ArcadeMenuItemPeresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController(this, widget.height / 6);
    presenter = ArcadeMenuItemPeresenter(
      notifyReactiveSink: widget.notifyReactiveSink
    )..setView = this
    ..initiateData();
  }

  @override
  void didUpdateWidget(ArcadeMenuItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.isActive != this.widget.isActive){
      if(!this.widget.isActive){
        if(controller.status == AnimationStatus.completed){
          controller.reverse();
          presenter.setNeedAdvancedMenu = false;
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: Stack(
        children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: widget.isActive? presenter.isNeedAdvancedMenu ? (){} : presenter.checkingStages : (){},
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: widget.width,
                  height: widget.height,
                  margin: widget.isActive ? EdgeInsets.fromLTRB(10, 0, 10, 20) : EdgeInsets.fromLTRB(15, 30, 15, 15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.menu['color'],
                        widget.menu['gradientColor']
                      ],
                      stops: [
                        0,0.8
                      ],

                    ),
                    border: Border.all(
                      color: widget.menu['borderColor'],
                      width: widget.width / 8
                    ),
                    borderRadius: BorderRadius.circular((widget.width / 2) + (widget.height / 2) / 2),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: widget.isActive ? 10 : 0,
                        color: Color(0x99333333),
                        spreadRadius: 0,
                        offset: widget.isActive ? Offset(3,12) : Offset(0,0)
                      )
                    ]
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: presenter.isNeedAdvancedMenu ? iconSlider.value : 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: widget.isActive? presenter.isNeedAdvancedMenu ? (){} : presenter.checkingStages : (){},
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  margin: const EdgeInsets.only(bottom: 17),
                  child: Center(
                    child: Image.asset(
                      "assets/images/arcade-menu.png",
                      width: widget.width / 2,
                      fit: BoxFit.fitWidth,
                      color: widget.menu['iconColor'],
                      colorBlendMode: BlendMode.srcATop,
                      filterQuality: FilterQuality.high,
                    ),
                  )
                ),
              ),
            ),
            
            Positioned(
              bottom: 0,
              left: 30,
              right: 30,
              height: 160,
              child: presenter.isNeedAdvancedMenu ?  Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[   
                      Transform.scale(
                        scale: presenter.isNeedAdvancedMenu ? animationContinue.value:0,
                        child: ArcadeItemMenuButton(
                          onTap: presenter.continueArcade,
                          title: "Continue",
                          color: widget.menu['iconColor'],
                        ),
                      ),

                      Transform.scale(
                        scale: presenter.isNeedAdvancedMenu? animationNewGame.value : 0,
                        child: ArcadeItemMenuButton(
                          onTap: presenter.initiateArcade,
                          title: "New Game",
                          color: widget.menu['iconColor'],
                        ),
                      )
                  ],
                ),
              ) : Container(),
            )
        ],
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