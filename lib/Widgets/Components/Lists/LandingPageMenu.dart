import 'dart:async';

import 'package:findpairs/PresenterViews/Components/Lists/LandingPageMenuView.dart';
import 'package:findpairs/Presenters/Components/Lists/LandingPageMenuPresenter.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/LandingPageMenuItem.dart';
import 'package:flutter/material.dart';

class LandingPageMenu extends StatefulWidget {

  final StreamController streamController;
  LandingPageMenu({@required this.streamController});


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
      children: presenter.menus.map((item)=> LandingPageMenuItem(isActive: presenter.menus.indexOf(item) == activePage, menu: item)).toList(),
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