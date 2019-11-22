import 'package:findpairs/PresenterViews/Pages/SelectArcadeStageView.dart';
import 'package:findpairs/Presenters/Pages/SelectArcadeStagePresenter.dart';
import 'package:findpairs/Utils/CommonUtil.dart';
import 'package:findpairs/Widgets/Components/Buttons/PauseActionButton.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/ArcadeSelections/FinishedStageSelection.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/ArcadeSelections/LockStageSelection.dart';
import 'package:findpairs/Widgets/Components/Lists/Items/ArcadeSelections/OpenStageSelection.dart';
import 'package:findpairs/Widgets/Pages/WrapperPage.dart';
import 'package:flutter/material.dart';

class SelectArcadeStage extends StatefulWidget {

  @override
  _SelectArcadeStageState createState() => _SelectArcadeStageState();
}

class _SelectArcadeStageState extends State<SelectArcadeStage> with SelectArcadeStageView{

  SelectArcadeStagePresenter presenter;

  @override
  void initState() {
    super.initState();
    setPageController = activeIndex;
    presenter = SelectArcadeStagePresenter()..setView = this..initiateData();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      actions: <Widget>[
          PauseActionButton(
            sinker: presenter.pauseSink,
          )
      ],
      leftHeader: Container(),
      child: PageView(
        controller: pageController,
        children: presenter.log.episodes.map((episode){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Center(
                  child: Text(
                    episode.episode,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display2.apply(
                      color: Color(0xfffaa675)
                    ),
                  ),
                ),
              ),
              Expanded(
                child: viewMode == 0 ?
                ListView(
                  children: List.generate((episode.logs.length / 3).ceil(), (i){
                    CommonUtil.instance.showLog(log:"index "+i.toString());
                    int start = i*3;
                    int end = start + 3;
                    if(end > episode.logs.length){
                      end = episode.logs.length;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: episode.logs.getRange(start, end).map((stages){
                          if(stages.isLocked){
                            return LockStageSelection(
                              width: getStageWidth(),
                              height: getStageHeight(),
                              stage: stages.stage,
                            );
                          }else{
                            if(stages.star < 0){
                              //new open
                              return OpenStageSelection(
                                episode: episode.episode,
                                width: getStageWidth(),
                                height: getStageHeight(),
                                stage: stages.stage,
                              );
                            }else{  
                              //already have star
                              return FinishedStageSelection(
                                width: getStageWidth(),
                                height: getStageHeight(),
                                stage: stages.stage,
                                episode: episode.episode,
                                star: stages.star,
                              );
                            }
                          }
                        }).toList(),
                      ),
                    );
                  }).toList(),
                )
                : Container(),
              )
            ],
          );
        }).toList(),
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
  BuildContext currentContext() {
    return context;
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }
}