import 'package:equatable/equatable.dart';

class Beacon extends Equatable {
  final String id;
  final String tag;
  final String image;
  final String information;


  Beacon({this.id, this.tag, this.information, this.image}) : super([id, tag, information,image]);

  @override
  String toString() => 'Beacon { id: $id }';
}