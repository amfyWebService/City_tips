import 'package:city_tips/core/model/Beacon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BeaconRepository {
  CollectionReference beaconCollection;
  CollectionReference userCollection;
  FirebaseUser user;

  BeaconRepository() {
    this.beaconCollection = Firestore.instance.collection('beacons');
    this.userCollection = Firestore.instance.collection('users');
  }

  Future<List<Beacon>> getUserBeacons({@required String userId}) async {
    List<Beacon> beacons = new List();
    try {
      userCollection.where("userId", isEqualTo: userId).snapshots().listen((data) =>
          data.documents.forEach((beacon) => beacons.add(new Beacon(
              id: beacon['id'],
              title: beacon['title'],
              tag: beacon['tag'],
              image: beacon['image'],
              information: beacon['information']))));
    } catch (error) {
      print(error.toString());
    }
    return beacons;
  }

  Future<Beacon> getBeacon({@required String beaconId}) async {
    Beacon beacon;
    try {
      beaconCollection.where("id", isEqualTo: beaconId).snapshots().listen((data) =>
          data.documents.forEach((data) => beacon = new Beacon(
              id: data['id'],
              title: data['title'],
              tag: data['tag'],
              image: data['image'],
              information: data['information'])));
    } catch (error) {
      print(error.toString());
    }
    return beacon;
  }

  Future<void> createBeacon({@required Beacon beacon}) async {
    try {
      await beaconCollection.document().setData({
        'id': new Uuid().v4(),
        'title': beacon.title,
        'tag': beacon.tag,
        'image': beacon.image,
        'information': beacon.information
      });
    } catch (error) {
      print(error.toString());
    }
  }

    Future<void> addFavorite({@required Beacon beacon}) async {
    try {
      await userCollection.document().setData({
        'id': beacon.id,
        'title': beacon.title,
        'tag': beacon.tag,
        'image': beacon.image,
        'information': beacon.information
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Map<String, dynamic> _toMap(Beacon item, [Map<String, dynamic> other]) {
    
    final Map<String, dynamic> result = {};
    if (other != null) {
      result.addAll(other);
    }
    result.addAll(item.toMap());
    result['userId'] = user.uid;

    return result;
  }
}
