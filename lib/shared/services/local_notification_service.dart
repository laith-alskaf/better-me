import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService();

  final _LocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  late final DarwinInitializationSettings iOSInitializationSettings;

  Future<void> intialize() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(
        '@drawable/ic_stat_healing');
    
    iOSInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    
    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iOSInitializationSettings
    );
    await _LocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      playSound: true,
    );
    const DarwinNotificationDetails iOSNotificationDetails = DarwinNotificationDetails();
    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );
  }
  Future<void> shownotifaction({
  required int id ,
  required String title,
  required String body,
})async{
    final details = await _notificationDetails();
    await _LocalNotificationsPlugin.show(id, title, body, details);
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    print('payload $payload');
  }

  Future<void> onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    print('id $id');
  }
}