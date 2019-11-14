import 'package:findpairs/PresenterViews/Components/Lists/Items/MatcherMenuItemView.dart';
import 'package:findpairs/Presenters/Components/Lists/Items/MatcherMenuItemPresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:flutter/material.dart';

class MatcherMenuItem extends StatefulWidget {

  final bool isActive;
  final Map<String,dynamic> menu;
  final double width;
  final double height;
  MatcherMenuItem({this.isActive, this.menu, this.height, this.width});

  @override
  _MatcherMenuItemState createState() => new _MatcherMenuItemState();
}

class _MatcherMenuItemState extends State<MatcherMenuItem> with MatcherMenuItemView{


  MatcherMenuItemPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = MatcherMenuItemPresenter()
    ..setView = this
    ..initiateData();
  }

  @override
  void didUpdateWidget(MatcherMenuItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.isActive != this.widget.isActive){
      if(!this.widget.isActive){
        presenter.initiateData();
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
              onTap: presenter.openingMatcherPage,
              child: AnimatedContainer(
                width: widget.width,
                height: widget.height,
                duration: const Duration(milliseconds: 300),
                margin: widget.isActive ? EdgeInsets.fromLTRB(10, 0, 10, 20) : EdgeInsets.fromLTRB(15, 30, 15, 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.menu['color'],
                      widget.menu['gradientColor']
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0,0.8
                    ]
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
              )
            ),
          ),

          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: presenter.openingMatcherPage,
              child: Container(
                width: widget.width,
                height: widget.height,
                margin: const EdgeInsets.only(bottom: 17),
                child:  Center(
                  child: Image.asset(
                    widget.menu['icon'],
                    width: widget.width  / 2,
                    fit: BoxFit.fitWidth,
                    color: widget.menu['iconColor'],
                    colorBlendMode: BlendMode.srcATop,
                    filterQuality: FilterQuality.high,
                  ),
                )
              ),
            )
          ),

          Positioned(
            left: 30,
            right: 30,
            bottom: 60,
            child: presenter.isNeedShowScore ?
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    Text(
                      "Best Score",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.display3.apply(
                        color: Colors.white
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        CommonUtil.instance.formatScore(presenter.score.score),
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.apply(
                          color: Colors.white
                        ),
                      ),
                    )

                  ],
                ),
              )
            : Container(),
          )

        ],
      ),
    );
  }

  @override
  BuildContext currentContext() => context;
}