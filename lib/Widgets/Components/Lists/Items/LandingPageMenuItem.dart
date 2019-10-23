import 'package:findpairs/PresenterViews/Components/Lists/Items/LandingPageMenuItemView.dart';
import 'package:findpairs/Widgets/Pages/StagesPage.dart';
import 'package:flutter/material.dart';

class LandingPageMenuItem extends StatefulWidget {

  final bool isActive;
  final Map<String,dynamic> menu;
  LandingPageMenuItem({this.isActive, this.menu});

  @override
  _LandingPageMenuItemState createState() => new _LandingPageMenuItemState();
}

class _LandingPageMenuItemState extends State<LandingPageMenuItem> with LandingPageMenuItemView{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StagesPage(stage: 1, episode: "episode01",)
          ));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
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
              
            ],
          ),
        ),
      ),
    );
  }

  @override
  BuildContext currentContext() => context;
}