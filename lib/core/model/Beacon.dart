import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Beacon extends Equatable {
  final String id;
  final String title;
  final String tag;
  final String image;
  final String information;
  final LatLng location;

  Beacon({this.id, this.title, this.tag, this.information, this.image,this.location}) : super([id, title, tag, information,image,location]);

  @override
  String toString() => 'Beacon { id: $id }';
}