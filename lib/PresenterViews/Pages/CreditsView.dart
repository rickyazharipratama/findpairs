import 'package:flutter/material.dart';

class CreditsView{

  ScrollController _controller;

  ScrollController get controller => _controller;

  setController(){
    _controller = ScrollController();
  }
}