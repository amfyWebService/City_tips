

import 'dart:io';

import 'package:city_tips/components/LoadingIndicator.dart';
import 'package:city_tips/core/auth/auth.dart';
import 'package:city_tips/core/repositories/UserRepository.dart';
import 'package:city_tips/views/HomePage.dart';
import 'package:city_tips/views/LoginPage.dart';
import 'package:city_tips/views/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preferences/preferences.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() async {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  await PrefService.init(prefix: 'pref_');

  runApp(App(userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;
var flutterLocalNotificationsPlugin ;
  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.dispatch(AppStarted());
    initPushNotification();
    initRanging();
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {

              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();

              //initranging();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }

  void initPushNotification()
  {
   flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(onDidReceiveLocalNotification: onDidRecieveLocationLocation);
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  void initRanging() {

    flutterBeacon.initializeScanning;
    final regions = <Region>[];

    if (Platform.isIOS) {
      debugPrint("ok");
      regions.add(Region(
          identifier: 'Apple Airlocate',
          proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0'));
    } else {

      // android platform, it can ranging out of beacon that filter all of Proximity UUID
      regions.add(Region(identifier: 'com.beacon'));
    }

    flutterBeacon.ranging(regions).listen((RangingResult result) {
      debugPrint(result.beacons.toString());
      // result contains a region and list of beacons found
      // list can be empty if no matching beacons were found in range
    });

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(0, 'plain title', 'plain body', platformChannelSpecifics, payload: 'item id 2');
  }

  Future onDidRecieveLocationLocation(int id, String title, String body, String payload)
  {
   debugPrint("ok");
  }

  Future onSelectNotification(String payload)
  {
    debugPrint("ok2");
  }
}