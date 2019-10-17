import 'dart:async';

import 'package:findpairs/Factories/Painters/ParticlePainter.dart';
import 'package:findpairs/PresenterViews/Components/Lists/Items/ArcadeLifeItemView.dart';
import 'package:findpairs/Presenters/Components/Lists/Items/ArcadeLIfeItemPresenter.dart';
import 'package:findpairs/Utils/EnumUtils.dart';
import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class ArcadeLifeItem extends StatefulWidget {
  final Stream<int> lifeStream;
  final StreamSink<bool> sinker;
  final int tag;

  ArcadeLifeItem({this.lifeStream, this.sinker,this.tag});

  @override
  _ArcadeLifeItemState createState() => new _ArcadeLifeItemState();
}

class _ArcadeLifeItemState extends State<ArcadeLifeItem> with TickerProviderStateMixin, ArcadeLifeItemView{

  ArcadeLifeItemPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController(this, ExplodeType.Drop);
    presenter = ArcadeLifeItemPresenter(widget.lifeStream, widget.sinker,widget.tag)..setView = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.value < 0.3 ?
      Transform(
        transform: Matrix4.translation(getShakingTranslation(progress: shakingAnimation.value)),
        child: IconShadowWidget(
          Icon(
            Icons.favorite,
            color: Colors.red,
            size: 40,
          ),
          shadowColor: Color(0xff333333),
          showShadow: true,
        )
      ): Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          width: 40,
          height: 40,
          child: CustomPaint(
            foregroundPainter: ParticlePainter(
              particles: presenter.particles,
              span: animationController.value
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
    presenter.dispose();
    super.dispose();
  }
}