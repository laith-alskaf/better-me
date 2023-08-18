import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart ' as tz;

class LocalNotifactionService {
  LocalNotifactionService();

  final _LocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>().requestPermission();
  IOSInitializationSettings iOSInitializationSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:onDidReceiveLocalNotification
  );

  Future <void> intialize() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(
        '@drawable/ic_stat_healing');
    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iOSInitializationSettings
    );
    await _LocalNotificationsPlugin.initialize(settings,onSelectNotification:onSelectNotification );
  }
  Future<NotificationDetails>_notificationDetails()async{
    const AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      // priority:Priority.max,
      playSound: true,
    );
    const IOSNotificationDetails iOSNotificationDetails=IOSNotificationDetails();
    return NotificationDetails(android:androidNotificationDetails,iOS:iOSNotificationDetails );
  }
  Future<void> shownotifaction({
  required int id ,
  required String title,
  required String body,
})async{
    final details = await _notificationDetails();
    await _LocalNotificationsPlugin.show(id, title, body, details);
  }

  void onSelectNotification(String? payload) {
    print('payload $payload');
  }

  static void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    print('id $id');
  }
}