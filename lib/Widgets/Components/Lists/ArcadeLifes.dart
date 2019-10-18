import 'package:findpairs/PresenterViews/Components/Lists/ArcadeLifesView.dart';
import 'package:findpairs/Presenters/Components/Lists/ArcadeLifesPresenter.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/ArcadeLifeItem.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/ArcadeLifeItemExtended.dart';
import 'package:flutter/material.dart';

class ArcadeLifes extends StatefulWidget {

  final int lifes;
  final Stream<bool> stream;

  ArcadeLifes({@required this.lifes, @required this.stream});

  @override
  _ArcadeLifesState createState() => new _ArcadeLifesState();
}

class _ArcadeLifesState extends State<ArcadeLifes> with  ArcadeLifesView{

  ArcadeLifesPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = ArcadeLifesPresenter(widget.stream, widget.lifes)..setView = this;
    presenter.initiateData();
  }

  @override
  void didUpdateWidget(ArcadeLifes oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(widget.lifes.toString());
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    print("extend : "+presenter.extendedLifes.toString());
    print("lifes : "+presenter.lifes.length.toString());
    return Container(
      width: 130,
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10,0),
      child: Stack(
        children: presenter.lifes.getRange(
          0, 
          presenter.extendedLifes > 0 ? presenter.lifes.length - presenter.extendedLifes : presenter.lifes.length
        ).map((rightVal){
          int idx = (rightVal / 15).round();
          return Positioned(
            top: 0,
            right: rightVal.toDouble(),
            width: idx < 4 ? 40 : presenter.extendedLifes > 0 ? 50 : 40,
            height: 40,
            child: idx < 4 ? 
              ArcadeLifeItem(
                lifeStream: presenter.lifeStream,
                tag: rightVal,
                sinker: presenter.extendedDispose,
              )
              : presenter.extendedLifes > 0 ?
                  Container(
                    width: 50,
                    height: 40,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          right: 0,
                          width: 40,
                          height: 40,
                          child: ArcadeLifeItem(
                            lifeStream: presenter.lifeStream,
                            tag: rightVal,
                            sinker: presenter.extendedDispose,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 20,
                          width: 25,
                          height: 25,
                          child: ArcadeLifeItemExtended(
                            lifeExtended: presenter.extendedLifes,
                            lifeExtendedStream: presenter.streamExtendeLife,
                            disposeWidget: presenter.extendedDispose,
                          ),
                        )
                      ],
                    ),
                  )
                : ArcadeLifeItem(
                  tag: rightVal,
                  lifeStream: presenter.lifeStream,
                  sinker: presenter.extendedDispose,
                )
          );
        }).toList()
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
    super.dispose();
    presenter.dispose();
  }
}