import 'package:city_tips/core/model/BeaconModel.dart';
import 'package:flutter/material.dart';

class BeaconPage extends StatelessWidget {
  BeaconModel beacon = new BeaconModel(
      id: '1',
      information: 'Un jour ici un homme ...',
      tag: 'Fact',
      image:
          'https://quoifaireabordeaux.com/wp-content/uploads/2018/12/ec8036126d1342c58e809b8397f80732.jpg');

  @override
  Widget build(BuildContext context) {
   // padding: const EdgeInsets.all(32);
    Widget description = Container(
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
          Icon(
        Icons.favorite,
        color: Colors.red[500],
      ),
      Text('41'),
        ],
      ),
    );

    return Container(
        child: Column(
          children: [
            Image.network(beacon.image), 
            description
          ]
        )
      );
  }
}
