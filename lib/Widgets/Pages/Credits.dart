import 'package:findpairs/PresenterViews/Pages/CreditsView.dart';
import 'package:findpairs/Presenters/Pages/CreditsPresenter.dart';
import 'package:findpairs/Widgets/Components/Text/CreditsSection.dart';
import 'package:findpairs/Widgets/Pages/WrapperPage.dart';
import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  @override
  _CreditsState createState() => new _CreditsState();
}

class _CreditsState extends State<Credits> with CreditsView{

  CreditsPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = CreditsPresenter()
    ..setView = this
    ..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      leftHeader: Container(),
      actions: <Widget>[

        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 30,
          ),
        )

      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView(
          controller: controller,
          children: <Widget>[
            
            Text(
              "Thanks to",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display1.apply(
                color: Colors.white
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 10),
              child: Text(
                "Icons & Images",
                textAlign: TextAlign.center, 
                style: Theme.of(context).textTheme.display4.apply(
                  color: Colors.white
                ),
              ),
            ),

            CreditsSection(
              author: "Smashicons",
              authorLink: "https://www.flaticon.com/authors/smashicons",
              content: [
                "Galaxy Space Image Pack"
              ],
              contentLink: [
                "https://www.flaticon.com/packs/space-3"
              ],
            ),
    
            CreditsSection(
              author: "Freepik",
              authorLink: "https://www.flaticon.com/authors/freepik",
              content: [
                "Arcade Icon",
                "Matcher Icon",
                "Credits Icon"
              ],
              contentLink: [
                "https://www.flaticon.com/free-icon/portable_1687604",
                "https://www.flaticon.com/free-icon/buttons_1687569",
                "https://www.flaticon.com/free-icon/namaste_84284?term=namaste&page=1&position=6"
              ],
            ),

            CreditsSection(
              author: "Gregor Cresnar",
              authorLink: "https://www.flaticon.com/authors/gregor-cresnar",
              content: [
                "Finder Icon"
              ],
              contentLink: [
                "https://www.flaticon.com/free-icon/puzzle_20876š1"
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "Sounds Effect",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display4.apply(
                  color: Colors.white
                ),
              ),
            ),

            CreditsSection(
              author: "Skyes Audio",
              authorLink: "https://www.zapsplat.com/author/skyes-audio/",
              content: [
                "Losing life"
              ],
              contentLink: [
                "https://www.zapsplat.com/music/glass-bottle-break-smash-long-clink/"
              ],
            ),

            CreditsSection(
              author: "ZapSplat",
              authorLink: "https://www.zapsplat.com/author/zapsplat/",
              content: [
                "Flip Card",
                "Win Cheers",
                "Ready",
                "Set",
              ],
              contentLink: [
                "https://www.zapsplat.com/music/paper-kitchen-towel-roll-pick-up-grab-2/",
                "https://www.zapsplat.com/music/football-crowd-approx-150-cheering-indoors/",
                "https://www.zapsplat.com/music/game-tone-sci-fi-button-select-or-menu-sound-1/",
                "https://www.zapsplat.com/music/game-tone-sci-fi-button-select-or-menu-sound-2/"
              ],
            ),

            CreditsSection(
              author: "MyInstants",
              authorLink: "https://www.myinstants.com",
              content: [
                "disappointed lose"
              ],
              contentLink: [
                "https://www.myinstants.com/instant/aww/"
              ],
            ),

            CreditsSection(
              author: "The Sound Pack Three",
              authorLink: "https://www.zapsplat.com/author/thesoundpacktree/",
              content: [
                "Crisis Time"
              ],
              contentLink: [
                "https://www.zapsplat.com/music/alarm-clock-ticking/"
              ],
            ),

            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            )
          ],
        ),
      ),
    );
  }
}