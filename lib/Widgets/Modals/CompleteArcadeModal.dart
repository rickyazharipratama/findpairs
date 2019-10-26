import 'package:findpairs/PresenterViews/Components/Modals/CompleteArcadeModalView.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Components/Buttons/ArcadeResultButton.dart';
import 'package:flutter/material.dart';

class CompleteArcadeModal extends StatefulWidget {
  final int starScore;
  final String message;
  final String episode;

  CompleteArcadeModal({this.starScore, @required this.message, @required this.episode});
  
  @override
  _CompleteArcadeModalState createState() => new _CompleteArcadeModalState();
}

class _CompleteArcadeModalState extends State<CompleteArcadeModal> with TickerProviderStateMixin,CompleteArcadeModalView{


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
    setWrapperHeight = height - 20;
    setWrapperWidth = width;
    double iconHeight = wrapperHeight / 2;
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
                    ConstantCollections.arcadeDialogsIcon[widget.episode]['positive'],
                    height: iconHeight,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),

              Positioned(
                top: iconHeight - 20,
                left: 0,
                right: 0,
                child: Container(
                  height: wrapperHeight - iconHeight + 20,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular((wrapperWidth / 100) * 10),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff459a2f),
                        Color(0xff7cae6f)
                      ],
                      stops: [
                        0,0.8
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                    )
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                  
                          Expanded(
                            child: Transform.scale(
                              scale: animButton.value,
                              child: ArcadeResultButton(
                                onTap: (){
                                  Navigator.of(context).pop(ArcadeAction.retryGame);
                                },
                                title: "RETRY",
                              ),
                            ),
                          ),

                          Container(
                            width: 1,
                            height: 50,
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          ),

                          Expanded(
                            child: Transform.scale(
                              scale: animButton.value,
                              child: ArcadeResultButton(
                                onTap: (){
                                  Navigator.of(context).pop(ArcadeAction.nextStage);
                                },
                                title: "NEXT",
                              ),
                            ),
                          ),
                        ],
                      ) 
                    ],
                  ),
                ),
              ),
                
              Positioned(
                top: iconHeight - 75,
                left: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Transform.scale(
                      scale: star2.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Transform.rotate(
                          angle: -0.1,
                          child: Icon(
                            widget.starScore > 1 ? Icons.star : Icons.star_border,
                            size: 70,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),

                    Transform.scale(
                      scale: star1.value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Icon(
                          Icons.star,
                          size: 80,
                          color: Colors.yellow,
                        ),
                      ),
                    ),

                    Transform.scale(
                      scale: star3.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Transform.rotate(
                          angle: 0.1,
                          child: Icon(
                            widget.starScore > 2 ? Icons.star : Icons.star_border,
                            size: 70,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    )
                  ],
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