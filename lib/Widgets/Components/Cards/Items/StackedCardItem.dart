import 'dart:async';

import 'package:findpairs/Factories/Painters/ParticlePainter.dart';
import 'package:findpairs/PresenterViews/Components/Cards/Items/StackedCardItemView.dart';
import 'package:findpairs/Presenters/Components/Cards/Item/StackedCardItemPresenter.dart';
import 'package:findpairs/Utils/ConstantCollections.dart';
import 'package:flutter/material.dart';

class StackedCardItem extends StatefulWidget {

  final double width;
  final double height;
  final Stream<int> destroyStream;
  final StreamSink<bool> refillSink;
  final int value;

  StackedCardItem({
    @required this.width,
    @required this.height,
    @required this.destroyStream,
    @required this.refillSink,
    @required this.value
  });

  @override
  _StackedCardItemState createState() => new _StackedCardItemState();
}

class _StackedCardItemState extends State<StackedCardItem> with SingleTickerProviderStateMixin, StackedCardItemView{

  StackedCardItemPresenter presenter;  

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = StackedCardItemPresenter(
      cardHeight: widget.height,
      cardWidth: widget.width,
      destroyCardStream: widget.destroyStream,
      refillCardSink: widget.refillSink,
      val: widget.value
    )
    ..setView = this
    ..initiateData();
  }

  @override
  void didUpdateWidget(StackedCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(this.widget.value != oldWidget.value){
      presenter.val = this.widget.value;
      presenter.resetAnimate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return animationController.value < 0.4 ? 
      Transform(
        transform: Matrix4.translation(getShakingTranslation(progress: shakingAnimation.value)),
        child : AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular((widget.width / 100)*10),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Color(0xaa333333),
                offset: Offset(1,3)
              )
            ]
          ),
          child: Center(
            child: Image.asset(
              ConstantCollections.cards['Episode-01'][widget.value],
              width: (widget.width * 3) / 4,
              fit: BoxFit.fitWidth,
            ),
          ),
        )
      ) : Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          width: widget.width,
          height: widget.height,
          child: CustomPaint(
            foregroundPainter: ParticlePainter(
              particles: presenter.particles.particles,
              span: destroyAnimation.value
            ),
          ),
      )
    ;
  }

  @override
  BuildContext currentContext() {
    return context;
  }

  @override
  void notifyState() {
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