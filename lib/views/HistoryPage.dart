import 'package:city_tips/views/BeaconPage.dart';
import 'package:flutter/material.dart';
import 'package:city_tips/core/model/User.dart';
import 'package:city_tips/core/model/Beacon.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryPage extends StatelessWidget {

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
  
  Widget _buildBeaconItem(BuildContext context, int index){
    Beacon beacon = user.beacons[index];
    return ListTile(
          leading: Icon(Icons.location_on),
          title: Text(beacon.title),
          subtitle: Text(beacon.tag),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BeaconPage(beacon: beacon,)));
          },
        );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: _buildBeaconItem,
          itemCount: user.beacons.length,
      )          
    );
  }
}
