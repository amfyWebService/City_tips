import 'package:equatable/equatable.dart';

abstract class MenuState extends Equatable {}

class HistoryPageShowed extends MenuState {
  @override
  String toString() => 'AuthenticationUninitialized';
}