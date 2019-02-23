import 'package:equatable/equatable.dart';
import 'Beacon.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String password;
  final String email;
  final List<Beacon> beacons;


  User({this.id, this.username, this.password, this.email,this.beacons}) : super([id, username, password, email, beacons]);

  @override
  String toString() => 'User { id: $id }';
}