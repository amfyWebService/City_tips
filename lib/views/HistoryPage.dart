import 'package:city_tips/core/repositories/BeaconRepository.dart';
import 'package:city_tips/views/BeaconPage.dart';
import 'package:flutter/material.dart';
import 'package:city_tips/core/model/User.dart';
import 'package:city_tips/core/model/Beacon.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  BeaconRepository beaconRepository;

  HistoryPage({@required this.beaconRepository});
  @override
  _HistoryPageState createState() => _HistoryPageState();
  
}

class _HistoryPageState extends State<HistoryPage> {
  BeaconRepository get beaconRepository => widget.beaconRepository;

  Beacon beacon = new Beacon(
      title: "Fontaine des girondins",
      information: 'Un jour ici un homme ...',
      tag: 'Fact',
      image:'https://quoifaireabordeaux.com/wp-content/uploads/2018/12/ec8036126d1342c58e809b8397f80732.jpg');
  
  User user = new User(
    id: '1',
    username: 'patate',
    password: 'PatateDeBeurreSalée',
    beacons:  beaconRepository.getBeacons()
          
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
