
import 'package:city_tips/core/model/BeaconModel.dart';
import 'package:flutter/material.dart';

class BeaconPage extends StatelessWidget{
  BeaconModel beacon = new BeaconModel(id:'1',information:'Un jour ici un homme ...', tag: 'Fact',image: 'https://quoifaireabordeaux.com/wp-content/uploads/2018/12/ec8036126d1342c58e809b8397f80732.jpg');

  Widget description = Container(
    child: Row(
      children: <Widget>[
       Expanded(child: Column(
          children: <Widget>[
           
          ],
        ),
       )
      ],
    ),

  );


  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Beacon'),
      ),
      body: Column(
        children: [
          Image.network(beacon.image)
              
        ]
       
      )
   );
  }
}