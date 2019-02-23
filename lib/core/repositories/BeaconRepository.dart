import 'package:city_tips/core/model/Beacon.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BeaconRepository {
  CollectionReference beaconCollection;

  BeaconRepository() {
    this.beaconCollection = Firestore.instance.collection('beacons');
  }
  Future<List<Beacon>> getBeacons() async {
    List<Beacon> beacons = new List();
    try {
      beaconCollection.snapshots().listen((data) =>
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
  Future<List<Beacon>> getBeacon({@required String id}) async {
    List<Beacon> beacons = new List();
    try {
      beaconCollection.where("id", isEqualTo: id).snapshots().listen((data) =>
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

  Future<Beacon> createBeacon({
    @required String title,
    @required String tag,
    @required String image,
    @required String information,
  }) async {
    Beacon beacon = new Beacon(
        id: new Uuid().v1(),
        title: title,
        tag: tag,
        image: image,
        information: information);
    try {
      await beaconCollection.document().setData({
        'id': beacon.id,
        'title': beacon.title,
        'tag': beacon.tag,
        'image': beacon.image,
        'information': beacon.information
      });
    } catch (error) {
      print(error.toString());
    }
    return beacon;
  }
}
