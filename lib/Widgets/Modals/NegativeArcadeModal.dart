import 'package:findpairs/PresenterViews/Components/Modals/NegativeArcadeModalView.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Components/Buttons/ArcadeResultButton.dart';
import 'package:flutter/material.dart';

class NegativeArcadeModal extends StatefulWidget 
{
  @override
  _NegativeArcadeModalState createState() => new _NegativeArcadeModalState();
}


class _NegativeArcadeModalState extends State<NegativeArcadeModal> with SingleTickerProviderStateMixin,NegativeArcadeModalView{

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    setWidth = MediaQuery.of(currentContext()).size.width / 2;
    setHeight = width;
    setWrapperHeight = height;
    setWrapperWidth = width;
    return Center(
      child: Transform.scale(
        scale: animation.value,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: wrapperHeight,
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular((wrapperWidth / 100)*5),
                    color: Colors.red
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      width: 25,
                    ),

                    Expanded(
                      child: ArcadeResultButton(
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).pop(ArcadeAction.retryGame);
                        },
                        title: "RETRY",
                      ),
                    ),

                    Container(
                      width: 20,
                    ),

                    Expanded(
                      child: ArcadeResultButton(
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).pop(ArcadeAction.exitGame);
                        },
                        title: "EXIT",
                      ),
                    ),

                    Container(
                      width: 25,
                    )
                  ],
                ),
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
  void notifyState(){
    if(mounted){
      setState(() {
        
      });
    }
  }
}