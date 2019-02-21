import 'package:city_tips/core/model/Beacon.dart';
import 'package:flutter/material.dart';

class BeaconPage extends StatefulWidget {
  Beacon beacon;

  BeaconPage({@required this.beacon});

  @override
  _BeaconPageState createState() => _BeaconPageState();
}

class _BeaconPageState extends State<BeaconPage> {
  int _favoriteCount = 0;
  Beacon get beacon => widget.beacon;

  @override
  Widget build(BuildContext context) {
   // padding: const EdgeInsets.all(32);
    Widget description = Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(beacon.information, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                Text(beacon.tag),
              ],
            ),
          ),
          IconButton(icon:(Icon(Icons.favorite)),
        color: Colors.red[500], onPressed: () => setState((){_favoriteCount++;}),
      ),
      
      Text('$_favoriteCount'),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("${beacon.title}"),
      ),
      body: Container(
        child: Column(
          children: [
            Image.network(beacon.image), 
            description
          ]
        )
      )
    );
  }

 
}
