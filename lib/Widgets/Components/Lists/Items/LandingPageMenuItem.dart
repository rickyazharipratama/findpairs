import 'package:findpairs/PresenterViews/Components/Lists/Items/LandingPageMenuItemView.dart';
import 'package:findpairs/Widgets/Pages/FInderPage.dart';
import 'package:findpairs/Widgets/Pages/SurvivalPage.dart';
import 'package:flutter/material.dart';

class LandingPageMenuItem extends StatefulWidget {

  final bool isActive;
  final Map<String,dynamic> menu;
  final double width;
  final double height;
  LandingPageMenuItem({this.isActive, this.menu, this.height, this.width});

  @override
  _LandingPageMenuItemState createState() => new _LandingPageMenuItemState();
}

class _LandingPageMenuItemState extends State<LandingPageMenuItem> with LandingPageMenuItemView{
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
              onTap: (){
                if(widget.menu['name'].toString().toLowerCase() == "finder"){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=> FinderPage()
                  ));
                }else if(widget.menu['name'].toString().toLowerCase() == "survival"){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=> SurvivalPage()
                  ));
                }
              },
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
            height: widget.height,
            child: Center(
              child: Image.asset(
                widget.menu['icon'],
                width: widget.width  / 2,
                fit: BoxFit.fitWidth,
                color: widget.menu['iconColor'],
                colorBlendMode: BlendMode.srcATop,
                filterQuality: FilterQuality.high,
              ),
            )
          )
        ],
      ),
    );
  }

  @override
  BuildContext currentContext() => context;
}