import 'dart:io';

import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconDetectionService
{
   final regions = <Region>[];
   BeaconDetectionService(List<String> args)
  {
    try
    {
       flutterBeacon.initializeScanning;
    }
    on Exception
    {
          // library failed to initialize, check code and message
    }
    if (Platform.isIOS)
    {
      regions.add(Region(
          identifier: 'Apple Airlocate',
          proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0'));
    }
    else{

      // android platform, it can ranging out of beacon that filter all of Proximity UUID
      regions.add(Region(identifier: 'com.beacon'));
    }

    flutterBeacon.ranging(regions).listen((RangingResult result) {

      // result contains a region and list of beacons found
      // list can be empty if no matching beacons were found in range
    });
  }


}