import 'package:findpairs/Widgets/Pages/Credits.dart';
import 'package:flutter/material.dart';
import 'package:navigatorium/navigatorium.dart';

class CreditsMenuItem extends StatelessWidget {

  final double width;
  final double height;
  final Map<String,dynamic> menu;
  final bool isActive;

  CreditsMenuItem({@required this.width,@required this.height, @required this.menu, @required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: (){
                Navigatorium.instance.push(
                  context,
                  child: Credits()
                );
              },
              child: AnimatedContainer(
                width: width,
                height: height,
                duration: const Duration(milliseconds: 300),
                margin: isActive ? EdgeInsets.fromLTRB(10, 0, 10, 20) : EdgeInsets.fromLTRB(15, 30, 15, 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      menu['color'],
                      menu['gradientColor']
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0,0.8
                    ]
                  ),
                  border: Border.all(
                    color: menu['borderColor'],
                    width: width / 8
                  ),
                  borderRadius: BorderRadius.circular((width / 2) + (height / 2) / 2),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: isActive ? 10 : 0,
                      color: Color(0x99333333),
                      spreadRadius: 0,
                      offset: isActive ? Offset(3,12) : Offset(0,0)
                    )
                  ]
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: (){
                Navigatorium.instance.push(
                  context,
                  child: Credits()
                );
              },
              child: Container(
                width: width,
                height: height,
                margin: const EdgeInsets.only(bottom: 17),
                child:  Center(
                  child: Image.asset(
                    menu['icon'],
                    width: width  / 2,
                    fit: BoxFit.fitWidth,
                    color: menu['iconColor'],
                    colorBlendMode: BlendMode.srcATop,
                    filterQuality: FilterQuality.high,
                  ),
                )
              ),
            )
          ),
        ],
      ),
    );
  }
}