import 'dart:io';

import 'package:city_tips/components/LocalNotification.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconDetectionService
{
   final regions = <Region>[];
   final listUUID = List<String>();
   LocalNotification notifier;
   BeaconDetectionService()
   {
     notifier = LocalNotification();
     launchService();
   }
   void launchService() async
  {

    try
    {
      await flutterBeacon.initializeScanning;
    } on Exception
    {
      // library failed to initialize, check code and message
    }

    if (Platform.isIOS) {
      regions.add(Region(
          identifier: 'Apple Airlocate',
          proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0'));
    } else {

      // android platform, it can ranging out of beacon that filter all of Proximity UUID
      regions.add(Region(identifier: 'com.beacon'));
    }

    flutterBeacon.ranging(regions).listen((RangingResult result)
    {
      for(int i = 0; i < result.beacons.length;i++)
      {
          if(!isIDAlreadyNotified(result.beacons[i].proximityUUID))
          {
            listUUID.add(result.beacons[i].proximityUUID);
            notifier.newNotification("new notif", "new beacon detected", result.beacons[i].proximityUUID);          }
      }

    });
  }
  bool isIDAlreadyNotified(String id)
  {
    if(listUUID.contains(id)) return true;
    return false;
  }

}