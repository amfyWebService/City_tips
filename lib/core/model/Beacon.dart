import 'package:equatable/equatable.dart';

class Beacon extends Equatable {
  final String id;
  final String title;
  final String tag;
  final String image;
  final String information;


  Beacon({this.id, this.title, this.tag, this.information, this.image}) : super([id, title, tag, information,image]);
  
  Beacon.fromMap(Map<String, dynamic> data)
      : this(id: data['id'], title: data['title'], tag: data['tag'], image: data['image'], information: data['information']);
  
  Map<String, dynamic> toMap() => {
      'id': this.id,
      'title': this.title,
      'tag': this.tag,
      'image': this.image,
      'information': this.information,
    };
 
  @override
  String toString() => 'Beacon { id: $id }';
}