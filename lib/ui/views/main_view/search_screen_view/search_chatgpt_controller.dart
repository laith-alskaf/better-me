import 'package:BetterMe/core/enums/connectivity_status.dart';
import 'package:BetterMe/core/services/connectivity_service.dart';
import 'package:BetterMe/ui/shared/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:bot_toast/bot_toast.dart';

class SearchChatgptController extends GetxController{
  ConnectivityStatus connectivityStatus = ConnectivityStatus.OFFLINE;
  RxBool isOnLine=true.obs;
  @override
  void onInit() async {
    // connectivityService;
    checkConnection();
    super.onInit();
  }
  set setConnectivityStatus(ConnectivityStatus value) {
    connectivityStatus = value;
  }

  void listenForConnectivityStatus() {
    // print("Connection From MyAppController First initial $connectivityStatus");
    connectivityService.connectivityStatusController.stream.listen((event) {
      setConnectivityStatus = event;
      // print("Connection From MyAppController Changed To $event");

      // Get.put(HomeViewController()).isOnline.value =
      //     connectivityStatus == ConnectivityStatus.ONLINE ? true : false;

      // if (isOffline) {
      //   BotToast.closeAllLoading();
      //   showNoConnectionMessage();
      // }
    });
  }

  void checkConnection() {
    connectivityService.connectivityStatusController.stream.listen((event) {
      listenForConnectivityStatus();
      // setIsOnline = event;
      connectivityStatus=event;
      print("Connection From HomeViewController Changed To $event");
      isOnLine.value = event == ConnectivityStatus.ONLINE;
    });
  }
}