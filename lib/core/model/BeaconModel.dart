import 'package:equatable/equatable.dart';

class BeaconModel extends Equatable {
  final String id;
  final String tag;
  final String information;

  BeaconModel({this.id, this.tag, this.information}) : super([id, tag, information]);

  @override
  String toString() => 'Beacon { id: $id }';
}