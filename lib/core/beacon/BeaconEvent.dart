import 'package:equatable/equatable.dart';

abstract class BeaconEvent extends Equatable {
  BeaconEvent([List props = const[]]) : super(props);
}

class AppStarted extends BeaconEvent {
  @override
  String toString() => 'AppStarted';
}

