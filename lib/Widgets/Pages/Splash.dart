import 'package:findpairs/PresenterViews/Pages/SplashView.dart';
import 'package:findpairs/Presenters/Pages/SplashPresenter.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin, SplashView{

  SplashPresenter presenter;

  @override
  void initState() {
    super.initState();
    setAnimationController = this;
    presenter = SplashPresenter()
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Opacity(
          opacity: opacity.value,
          child: Transform.scale(
            scale: anim.value,
            child: RichText(
              text: TextSpan(
                text: "Coret",
                style: Theme.of(context).primaryTextTheme.display4
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  BuildContext currentContext() {
    return context;
  }

  @override
  void notifyState() {
    super.notifyState();
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