import 'package:equatable/equatable.dart';
import 'Beacon.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String password;
  final List<Beacon> beacons;


  User({this.id, this.username, this.password, this.beacons}) : super([id, username, password,beacons]);

  @override
  String toString() => 'User { id: $id }';
}