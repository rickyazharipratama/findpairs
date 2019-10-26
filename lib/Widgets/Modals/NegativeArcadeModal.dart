import 'package:findpairs/PresenterViews/Components/Modals/NegativeArcadeModalView.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Components/Buttons/ArcadeResultButton.dart';
import 'package:flutter/material.dart';

class NegativeArcadeModal extends StatefulWidget 
{
  final String episode;
  final String message;

  NegativeArcadeModal({@required this.episode, @required this.message});

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
    setHeight = width + width / 2;
    setWrapperHeight = height-20;
    setWrapperWidth = width;
    setIconWidth = wrapperHeight / 2;
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
                child: Center(
                  child: Image.asset(
                    ConstantCollections.arcadeDialogsIcon[widget.episode]['negative'],
                    height: iconWidth,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),

              Positioned(
                top: iconWidth - 20,
                left: 0,
                right: 0,
                child: Container(
                  height: wrapperHeight - iconWidth + 20,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular((wrapperWidth / 100)*10),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffb5292c),
                        Color(0xffc44548)
                      ],
                      stops: [
                        0,0.8
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Color(0x99333333),
                        offset: Offset(4,10)
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.message,
                            style: Theme.of(context).textTheme.subtitle.apply(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        )
                      ),
                      Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Transform.scale(
                              scale: animButton.value,
                              child: ArcadeResultButton(
                                onTap: (){
                                  Navigator.of(context, rootNavigator: true).pop(ArcadeAction.retryGame);
                                },
                                title: "RETRY",
                              ),
                            ),
                          ),

                          Container(
                            width: 1,
                            height: 60,
                            color: Colors.white,
                          ),

                          Expanded(
                            child: Transform.scale(
                              scale: animButton.value,
                              child: ArcadeResultButton(
                                onTap: (){
                                  Navigator.of(context, rootNavigator: true).pop(ArcadeAction.exitGame);
                                },
                                title: "EXIT",
                              ),
                            ),
                          ),
                        ],
                      ),                      
                    ],
                  ),
                ),
              ),
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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}