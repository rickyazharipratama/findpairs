import 'package:flutter/material.dart';

class ArcadeSeeYouNextEpisode extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                    Icon(
                      Icons.account_balance,
                      size: 120,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        "See You",
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),

                    Text(
                      "We will provide more interesting challenges in the next episode",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.display3,
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
              child: Icon(
                Icons.close,
                color: Colors.black,
                size: 40,
              ),
            ),
          )
        ],
      )
    );
  }
}