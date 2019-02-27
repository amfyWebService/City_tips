import 'package:equatable/equatable.dart';
import 'Beacon.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String password;
  final List<Beacon> beacons;


  User({this.id, this.username, this.email, this.password = "It's a secret 😉",this.beacons}) : super([id, username, email, password,beacons]);

  @override
  String toString() => 'User { id: $id }';
}