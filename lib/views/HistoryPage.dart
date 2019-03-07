import 'package:city_tips/views/BeaconPage.dart';
import 'package:flutter/material.dart';
import 'package:city_tips/core/model/User.dart';
import 'package:city_tips/core/model/Beacon.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:preferences/preference_service.dart';

class HistoryPage extends StatefulWidget {
  //DECLARER UN TABLEAU DE BEACON A REMPLIR 
  
  @override
  HistoryPageState createState() {
    return new HistoryPageState();
  }
}

class HistoryPageState extends State<HistoryPage> {
  List<Beacon> beacons = [];

  User user = new User(
    id: '1',
    username: 'patate',
    password: 'PatateDeBeurreSalée',
    beacons: <Beacon>[new Beacon(id: '1',
      title: "Fontaine des girondins",
      information: 'Un jour ici un homme est tombé de la Fontaine des girondins',
      tag: 'fact',
      location: LatLng(44.845500, -0.575970),
      image:
          'https://quoifaireabordeaux.com/wp-content/uploads/2018/12/ec8036126d1342c58e809b8397f80732.jpg'),
          new Beacon(id: '2',
      title: "Fnac",
      information: 'Super remise à la fnac -10% sur tous le magasin',
      location: LatLng(44.839943, -0.573931),
      tag: 'commercial',
      image:
          'http://www.girondemusicbox.fr/wp-content/uploads/2016/08/fnac-bordeaux-1.jpg'),
        new Beacon(id: '3',
      title: "Grosse cloche",
      information: 'La grosse cloche',
      location: LatLng(44.839943, -0.5714309999999614),
      tag: 'historic',
      image:
          'https://img.20mn.fr/yGwDQ2IfTlGsjvq5hO9WYw/310x190_grosse-cloche-bordeaux.jpg')
      
          
          ]

          
  );

  Widget _buildBeaconItem(BuildContext context, int index){

    Beacon beacon = beacons[index];
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
    beacons =[];
    for(var item in user.beacons){
      if (PrefService.getBool(item.tag)){
        beacons.add(item);
      }
    }
    return Container(
      child: ListView.builder(
          itemBuilder: _buildBeaconItem,
          itemCount: beacons.length,
      )          
    );
  }
}
