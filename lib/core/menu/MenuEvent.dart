import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  MenuEvent([List props = const []]) : super(props);
}

class HistoryPageSelected extends MenuEvent {

  @override
  String toString() => 'MenuHistory';
}