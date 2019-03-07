import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: new Theme(data: Theme.of(context).copyWith(accentColor: Colors.redAccent), child: new CircularProgressIndicator()),
  );
}