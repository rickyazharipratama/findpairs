import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/LandingPageMenuView.dart';
import 'package:findpairs/Presenters/Components/Lists/LandingPageMenuPresenter.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/ArcadeMenuItem.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/CreditsMenuItem.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/FinderMenuItem.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/MatcherMenuItem.dart';
import 'package:flutter/material.dart';

class LandingPageMenu extends StatefulWidget {

  final StreamController streamController;
  final StreamSink notifyReactiveSink;
  LandingPageMenu({@required this.streamController, @required this.notifyReactiveSink});

  @override
  _LandingPageMenuState createState() => new _LandingPageMenuState();
}

class _LandingPageMenuState extends State<LandingPageMenu> with LandingPageMenuView {

  LandingPageMenuPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = LandingPageMenuPresenter(
      streamController: widget.streamController
    )..setView = this;
    presenter.initiateData();
  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: presenter.onPageChanged,
      children: presenter.menus.map((item){
        if(item['name'].toString().toLowerCase() == "arcade"){
          return ArcadeMenuItem(
            notifyReactiveSink: widget.notifyReactiveSink,
            isActive: presenter.menus.indexOf(item) == activePage,
            menu: item,
            height: getCardHeight(),
            width: getCardWidth(),
          );
        }else if(item['name'].toString().toLowerCase() == "finder"){
          return FinderMenuItem(
            notifyReactiveSink: widget.notifyReactiveSink,
            isActive: presenter.menus.indexOf(item) == activePage,
            menu: item,
            height: getCardHeight(),
            width: getCardWidth(),
          );
        }else if(item['name'].toString().toLowerCase() == "matcher"){
          return MatcherMenuItem(
            notifyReactiveSink: widget.notifyReactiveSink,
            isActive: presenter.menus.indexOf(item) == activePage, 
            menu: item,
            height: getCardHeight(),
            width: getCardWidth(),
          );
        }else if(item['name'].toString().toLowerCase() == "credits"){
          return CreditsMenuItem(
            height: getCardHeight(),
            width: getCardWidth(),
            isActive: presenter.menus.indexOf(item) == activePage,
            menu: item,
          );
        }
      }).toList()
    );
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
  BuildContext currentContext() => context;
}