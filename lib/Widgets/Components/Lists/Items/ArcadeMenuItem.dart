import 'package:findpairs/PresenterViews/Components/Buttons/ArcadeItemMenuButton.dart';
import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeMenuItemView.dart';
import 'package:findpairs/Presenters/Components/Lists/Items/ArcadeMenuItemPresenter.dart';
import 'package:flutter/material.dart';

class ArcadeMenuItem extends StatefulWidget {

  final bool isActive;
  final Map<String,dynamic> menu;
  final double width;
  final double height;
  ArcadeMenuItem({this.isActive, this.menu, @required this.width, @required this.height});

  @override
  _ArcadeMenuItemState createState() => new _ArcadeMenuItemState();
}

class _ArcadeMenuItemState extends State<ArcadeMenuItem> with SingleTickerProviderStateMixin,ArcadeMenuItemView{

  ArcadeMenuItemPeresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = ArcadeMenuItemPeresenter()..setView = this..initiateData();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: GestureDetector(
        onTap: widget.isActive? presenter.isNeedAdvancedMenu ? (){} : presenter.checkingStages : (){},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widget.width,
          height: widget.height,
          margin: widget.isActive ? EdgeInsets.fromLTRB(10, 0, 10, 20) : EdgeInsets.fromLTRB(15, 30, 15, 15),
          decoration: BoxDecoration(
            color:widget.menu['color'],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: widget.isActive ? 17 : 0,
                color: widget.isActive ? Color(0x77333333) : Color(0x00333333),
                spreadRadius: 0,
                offset: widget.isActive ? Offset(8,18) : Offset(0,0)
              )
            ]
          ),
          child: Stack(
            children: <Widget>[
              
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: presenter.isNeedAdvancedMenu ? iconSlider.value : 0 ),
                    child: Image.asset(
                      "assets/images/arcade-menu.png",
                      width: widget.width * 3.5 / 5,
                      fit: BoxFit.fitWidth,
                      color: widget.menu['iconColor'],
                      colorBlendMode: BlendMode.srcATop,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),


              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 140,
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
                          ),
                        ),

                        Transform.scale(
                          scale: presenter.isNeedAdvancedMenu? animationNewGame.value : 0,
                          child: ArcadeItemMenuButton(
                            onTap: presenter.initiateArcade,
                            title: "New Game",
                          ),
                        )
                    ],
                  ),
                ) : Container(),
              )
            ],
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

}