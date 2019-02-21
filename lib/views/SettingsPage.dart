import 'package:flutter/widgets.dart';
import 'package:preferences/preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{

  @override
  Widget build(BuildContext context) {
    return PreferencePage([
      PreferenceTitle('Subscribe'),
      SwitchPreference(
        'Commercial',
        'sub_commercial',
        defaultVal: true,
      ),
      SwitchPreference(
        'Historic',
        'sub_historic',
        defaultVal: true,
      ),
       SwitchPreference(
        'Fact',
        'sub_fact',
        defaultVal: true,
      )
    ]);
  }
}