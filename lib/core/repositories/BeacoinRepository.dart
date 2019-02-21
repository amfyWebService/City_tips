
import 'package:city_tips/core/model/Beacon.dart';
import 'package:meta/meta.dart';

class BeaconRepository {
  Future<Beacon> getBeacon({
    @required String id,
    @required String tag,
    @required String information,
  })async {
    await Future.delayed(Duration(seconds: 1));
    return new Beacon(id: id, tag: tag, information: information);
  }
}