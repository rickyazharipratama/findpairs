import 'package:findpairs/PresenterViews/Components/Text/LandingPageTitleView.dart';
import 'package:findpairs/Presenters/Components/Text/LandingPageTitlePresenter.dart';
import 'package:flutter/material.dart';

class LandingPageTitle extends StatefulWidget {

  final Stream<Map<String,dynamic>> stream;

  LandingPageTitle({this.stream});

  @override
  _LandingPageTitleState createState() => new _LandingPageTitleState();
}

class _LandingPageTitleState extends State<LandingPageTitle> with TickerProviderStateMixin,LandingPageTitleView{

  LandingPageTitlePresenter presenter;

  @override
  void initState() {
    super.initState();
    setTick = this;
    presenter = LandingPageTitlePresenter(widget.stream)..setView = this;
    presenter.initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: presenter.animatedChars == null ? 
        Container() 
        : presenter.animatedChars.length == 0 ?
          Container()
          : RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.subtitle,
                children: presenter.animatedChars.map((char){
                  int i = char['tween'].animate(char['animationController']).value;
                  return TextSpan(
                    text: presenter.texts[i],
                    style: TextStyle(
                      color: Color(0xffc4a5a1)
                    )
                  );
                }).toList()
              ),
            )
        );
  }

  @override
  notifyState() {
    super.notifyState();
    if(mounted){
      setState(() {
        
      });
    }
  }

  @override
  void dispose() {
    presenter.clearAnimationController();
    super.dispose();
  }
}