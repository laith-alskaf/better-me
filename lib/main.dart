import 'package:BetterMe/core/services/connectivity_service.dart';
import 'package:BetterMe/ui/views/main_view/search_screen_view/search_chatgpt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:BetterMe/app/my_app.dart';
import 'package:BetterMe/core/data/repositories/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? globalSharedPreferences;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // globalSharedPreferences=await SharedPreferences.getInstance();

  await Get.putAsync<SharedPreferences>(
        () async {
      var sharedPref = await SharedPreferences.getInstance();
      return sharedPref;
    },);
  Get.put(SharedPreferance());
  Get.put(ConnectivityService());
  Get.put(SearchChatgptController());

  runApp( MyApp());
}


