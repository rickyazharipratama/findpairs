class FindPairsAppPresenterView{
    int _viewState = 1;

    int get viewState => _viewState;
    set setViewState(int st){
      _viewState = st;
    }

    void notifyState(){}
}