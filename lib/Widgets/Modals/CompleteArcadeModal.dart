import 'package:findpairs/PresenterViews/Components/Modals/CompleteArcadeModalView.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:findpairs/Widgets/Components/Buttons/ArcadeResultButton.dart';
import 'package:flutter/material.dart';

class CompleteArcadeModal extends StatefulWidget {
  final int starScore;
  final bool isHaveNextLevel;

  CompleteArcadeModal({this.starScore, this.isHaveNextLevel :true});
  
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
                top: 40,
                left: 0,
                right: 0,
                child: Container(
                  height: wrapperHeight,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular((wrapperWidth / 100) * 5),
                    color: Colors.green
                  ),
                ),
              ),

              Positioned(
                top: 0,
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

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: widget.isHaveNextLevel ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container( width: 25),
                    
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
                      width: 15,
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
                    Container( width: 25)
                  ],
                ) : 
                Center(
                  child: Transform.scale(
                    scale: animButton.value,
                    child: SizedBox(
                      width: wrapperWidth - 50,
                      height: 80,
                      child: ArcadeResultButton(
                        onTap: (){
                          Navigator.of(context).pop(ArcadeAction.exitGame);
                        },
                        title: "EXIT",
                      ),
                    ),
                  ),
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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}