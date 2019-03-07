import 'package:flutter/widgets.dart';
import 'package:preferences/preferences.dart';
import 'package:flutter/foundation.dart';
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{

  @override
  Widget build(BuildContext context) {
    bool historic = false;
    bool commercial = false;
    bool fact = false;
    return PreferencePage([
      PreferenceTitle('Subscribe'),
      SwitchPreference(
        'Commercial',
        'commercial',
        defaultVal: commercial,
        onEnable: (){
          commercial =true;
          debugPrint(commercial.toString());
        },
        onDisable: (){
          commercial = false;
          debugPrint(commercial.toString());
        },
      ),
      SwitchPreference(
        'Historic',
        'historic',
        defaultVal: historic,
        onEnable: (){
          historic =true;
          debugPrint(historic.toString());
        },
        onDisable: (){
          historic = false;
          debugPrint(historic.toString());
        },
      ),
       SwitchPreference(
        'Fact',
        'fact',
        defaultVal: fact,
        onEnable: (){
          fact =true;
          debugPrint(fact.toString());
        },
        onDisable: (){
          fact = false;
          debugPrint(fact.toString());
        },
      )
    ]);
  }
}