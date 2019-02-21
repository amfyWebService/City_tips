import 'package:city_tips/core/auth/AuthenticationBloc.dart';
import 'package:city_tips/core/auth/AuthenticationEvent.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  
  Widget _buildBeaconItem(BuildContext context, int index){
    return ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Map'),
        );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: _buildBeaconItem,
          itemCount: 1,
      )          
    );
  }
}
