import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/Items/FinderMenuItemView.dart';
import 'package:findpairs/Presenters/Components/Lists/Items/FinderMenuItemPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:findpairs/Widgets/Components/Buttons/ArcadeItemMenuButton.dart';
import 'package:flutter/material.dart';

class FinderMenuItem extends StatefulWidget {
  final bool isActive;
  final Map<String,dynamic> menu;
  final double width;
  final double height;
  final StreamSink<bool> notifyReactiveSink;

  FinderMenuItem({this.isActive, this.menu, this.width, this.height, @required this.notifyReactiveSink});

  @override
  _FinderMenuItemState createState() => new _FinderMenuItemState();
}

class _FinderMenuItemState extends State<FinderMenuItem> with SingleTickerProviderStateMixin,FinderMenuItemView{
  
    FinderMenuItemPresenter presenter;
  @override
  void initState() {
    super.initState();
    setAnimationController(this, widget.height / 6);
    presenter = FinderMenuItemPresenter(
      notifyReactiveSink: widget.notifyReactiveSink
    )
    ..setView = this
    ..initiateData();
  }

  @override
  didUpdateWidget(FinderMenuItem oldWidget){
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
                onTap: widget.isActive? presenter.isNeedAdvancedMenu ? (){} : presenter.checkingFinder : (){},
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
                onTap: widget.isActive? presenter.isNeedAdvancedMenu ? (){} : presenter.checkingFinder : (){},
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  margin: const EdgeInsets.only(bottom: 17),
                  child: Center(
                    child: Image.asset(
                      "assets/images/classic.png",
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
              bottom: 165,
              left: 30,
              right: 30,
              child: presenter.isNeedAdvancedMenu ?
                Transform.scale(
                  scale: textAnim.value,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Last Score",
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display3.apply(
                            color: Colors.white
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.display1.apply(
                                color: Colors.white
                              ),
                              children: [
                                TextSpan(
                                  text: CommonUtil.instance.formatScore(presenter.score.score),
                                ),
                                TextSpan(
                                  text: " ("+CommonUtil.instance.decimalFormat(presenter.score.ratio * 100)+"%)",
                                  style: Theme.of(context).textTheme.display3.apply(
                                    color: Colors.white,
                                    fontSizeDelta: 0.65,
                                    fontSizeFactor: 0.65
                                  )
                                )
                              ]
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                )
              : Container(),
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
                          onTap: openFinderStage,
                          title: "Continue",
                          color: widget.menu['iconColor'],
                        ),
                      ),

                      Transform.scale(
                        scale: presenter.isNeedAdvancedMenu? animationNewGame.value : 0,
                        child: ArcadeItemMenuButton(
                          onTap: presenter.resetAllScore,
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
  void notifyState(){
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