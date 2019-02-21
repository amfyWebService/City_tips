import 'package:equatable/equatable.dart';

abstract class BeaconState extends Equatable{}

class BeaconUninitialized extends BeaconState{
  @override 
  String toString() {
    
    return "Beacon uninitialized";
  }
}

class BeaconSuccess extends BeaconState{
  @override 
  String toString() {
    
    return "Beacon Succes";
  }
}

class BeaconError extends BeaconState{
  @override 
  String toString() {
    
    return "Beacon Error";
  }
}

class BeaconLoading  extends BeaconState{
  @override 
  String toString() {
  
  return  "Beacon Loading";
  }
}