import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:city_tips/core/model/User.dart';
import 'package:city_tips/core/model/Beacon.dart';
import 'package:location/location.dart';


class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapSample();
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();


  User user = new User(
    id: '1',
    username: 'patate',
    password: 'PatateDeBeurreSalée',
    beacons: <Beacon>[new Beacon(id: '1',
      title: "Fontaine des girondins",
      information: 'Un jour ici un homme ...',
      tag: 'Fact',
      location: LatLng(44.845500, -0.575970),
      image:
          'https://quoifaireabordeaux.com/wp-content/uploads/2018/12/ec8036126d1342c58e809b8397f80732.jpg'),
          new Beacon(id: '2',
      title: "La patate",
      information: 'Une patate ...',
      location: LatLng(0, 0),
      tag: 'Fact',
      image:
          'https://quoifaireabordeaux.com/wp-content/uploads/2018/12/ec8036126d1342c58e809b8397f80732.jpg')
          
          
          ]

          
  );


   GoogleMapController controller;
   MapType _currentMapType = MapType.satellite;
   LocationData currentLocation;

   var location = new Location();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          this.controller = controller;
          this.controller.updateMapOptions(GoogleMapOptions(mapType:MapType.satellite));
          user.beacons.forEach((beacon) => {
            this.addMarkerToMap(beacon)
          });
          _controller.complete(controller);
        },
      ),
      
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.map),
              onPressed: _onMapTypeButtonPressed,
            ),
            FloatingActionButton(
              child: Icon(Icons.location_on,),
              onPressed: _goToPosition,
            ),
          ],
        )
    );
  }

  Future<void> _goToPosition() async {
    location = new Location();
    try {
  currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 19.151926040649414)));
    
  }

  Future<void> _onMapTypeButtonPressed() async {
 if (_currentMapType == MapType.normal) {
   controller.updateMapOptions(
     GoogleMapOptions(mapType: MapType.satellite),
   );
   _currentMapType = MapType.satellite;
 } else {
   controller.updateMapOptions(
     GoogleMapOptions(mapType: MapType.normal),
   );
   _currentMapType = MapType.normal;
 }
}

  void addMarkerToMap(Beacon beacon) {
 controller.addMarker(
   MarkerOptions(
     
     position: beacon.location,
     infoWindowText: InfoWindowText(beacon.title, beacon.information),
     icon: BitmapDescriptor.defaultMarker,
   ),
 );
}
}