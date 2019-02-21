import 'dart:async';

import 'package:city_tips/core/menu/menu.dart';
import 'package:bloc/bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {

  MenuBloc();

  MenuState get initialState => HistoryPageShowed();

  @override
  Stream<MenuState> mapEventToState(MenuState currentState, MenuEvent event) async* {
    
    if (event is HistoryPageSelected) {
      yield HistoryPageShowed();
    }

    if(event is BeaconPageSelected) {
      yield BeaconPageShowed();
    }
  }
}