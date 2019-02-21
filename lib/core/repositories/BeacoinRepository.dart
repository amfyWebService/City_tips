
import 'package:city_tips/core/model/BeaconModel.dart';
import 'package:meta/meta.dart';

class BeaconRepository {
  Future<BeaconModel> getBeacon({
    @required String id,
    @required String tag,
    @required String information,
  })async {
    await Future.delayed(Duration(seconds: 1));
    return new BeaconModel(id: id, tag: tag, information: information);
  }
}