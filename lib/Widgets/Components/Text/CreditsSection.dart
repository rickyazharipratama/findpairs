import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsSection extends StatelessWidget {
  final String author;
  final String authorLink;
  final List<String> content;
  final List<String> contentLink;

  CreditsSection({@required this.author, @required this.authorLink, @required this.content, @required this.contentLink});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
        top: 5
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            author,
            style: Theme.of(context).textTheme.display3.apply(
              color: Colors.white
            ),
          ),
          GestureDetector(
            onTap: () async{
                if(await canLaunch(authorLink)){
                  launch(
                    authorLink,
                    forceSafariVC: false,
                    forceWebView: false
                  );
                }
            },
            child: Text(
              authorLink,
              style: Theme.of(context).textTheme.body2
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(content.length, (index){
                return Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content[index],
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Text(
                        contentLink[index],
                        style: Theme.of(context).textTheme.body2
                      ),
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}