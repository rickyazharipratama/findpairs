import 'package:findpairs/PresenterViews/Components/Buttons/ArcadeResultButtonView.dart';
import 'package:findpairs/Presenters/Components/Buttons/ArcadeResultButtonPresenter.dart';
import 'package:flutter/material.dart';

class ArcadeResultButton extends StatefulWidget {

  final String title;
  final VoidCallback onTap;

  ArcadeResultButton({@required this.title, @required this.onTap});

  @override
  _ArcadeResultButtonState createState() => new _ArcadeResultButtonState();
}

class _ArcadeResultButtonState extends State<ArcadeResultButton> with SingleTickerProviderStateMixin, ArcadeResultButtonView{

  ArcadeResultButtonPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = ArcadeResultButtonPresenter(
      title: widget.title,
      callback: widget.onTap
    )..setView = this;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: presenter.onTap,
      child: Transform.scale(
        scale: animation.value,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xffe8e8ef),
            boxShadow: [
              BoxShadow(
                color: Color(0x77333333),
                blurRadius: 17,
                offset: Offset(-1,18),
                spreadRadius: 0
              )
            ]
          ),
          child: Center(
            child: Text(
              presenter.title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display3,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

}