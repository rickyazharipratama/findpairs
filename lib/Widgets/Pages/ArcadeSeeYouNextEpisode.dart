import 'package:flutter/material.dart';

class ArcadeSeeYouNextEpisode extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[

          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                    Image.asset(
                      "assets/images/galaxies/project.png",
                      width: MediaQuery.of(context).size.width * 2/ 3,
                      fit:BoxFit.fitWidth
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: Text(
                        "See You!",
                        style: Theme.of(context).textTheme.display1.apply(
                          color: Colors.white
                        ),
                      ),
                    ),

                    Text(
                      "We will provide more interesting challenges in the next episode",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.display3.apply(
                        color: Color(0xffdfdfdf)
                      ),
                    )
                ],
              ),
            ),
          ),

          Positioned(
            right: 5,
            top: MediaQuery.of(context).padding.top + 5,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}