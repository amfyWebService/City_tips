import 'package:city_tips/core/beacon/Beacon.dart';
import 'package:city_tips/views/BeaconPage.dart';
import 'package:flutter/material.dart';
import 'package:city_tips/core/model/Beacon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
  
}

class _HistoryPageState extends State<HistoryPage> {
  BeaconBloc beaconBloc;
  List<Beacon> beacons;

  @override
  void initState() {
    beaconBloc = BlocProvider.of<BeaconBloc>(context);
    beaconBloc.userRepository.getUser().then((firebaseUser) => setState(() => beacons = firebaseUser.beacons));
    super.initState();
  }

  Widget _buildBeaconItem(BuildContext context, int index){
    Beacon beacon = beacons[index];
    return ListTile(
          leading: Icon(Icons.location_on),
          title: Text(beacon.title),
          subtitle: Text(beacon.tag),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BeaconPage(beacon: beacon)));
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: _buildBeaconItem,
          itemCount: beacons.length,
      )          
    );
  }
}
