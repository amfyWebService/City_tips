import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification
{
  int idNotif = 0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  LocalNotification()
  {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(onDidReceiveLocalNotification: onDidRecieveLocationLocation);

    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void newNotification(String title, String body, String idBeacon) async
  {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    //je ne sais pas à quoi serve les 3 string
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(idNotif, title, body, platformChannelSpecifics, payload: idBeacon);
    idNotif++;
  }

  Future onDidRecieveLocationLocation(int id, String title, String body, String payload) {
    //when user tap on notif for IOS (not sure tho)
  }
  Future onSelectNotification(String payload)
  {
    //when user tap on notif
  }
}