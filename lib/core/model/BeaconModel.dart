import 'package:equatable/equatable.dart';

class BeaconModel extends Equatable {
  final String id;
  final String tag;
  final String image;
  final String information;


  BeaconModel({this.id, this.tag, this.information, this.image}) : super([id, tag, information,image]);

  @override
  String toString() => 'Beacon { id: $id }';
}