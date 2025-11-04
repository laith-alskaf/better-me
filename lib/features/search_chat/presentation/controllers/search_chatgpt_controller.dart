import 'package:BetterMe/core/enums/connectivity_status.dart';
import 'package:BetterMe/core/services/connectivity_service.dart';
import 'package:get/get.dart';

/// SearchChatGPT Controller
/// يتحكم في حالة الاتصال والبحث عن ChatGPT والتحكم في حالة البحث
class SearchChatgptController extends GetxController {
  late final ConnectivityService connectivityService;
  
  ConnectivityStatus connectivityStatus = ConnectivityStatus.offline;
  final Rx<bool> isOnLine = true.obs;
  
  // Search state
  final Rx<bool> isSearching = false.obs;
  final Rx<String> searchQuery = ''.obs;
  final RxList<String> searchResults = <String>[].obs;

  @override
  void onInit() {
    connectivityService = Get.find<ConnectivityService>();
    checkConnection();
    super.onInit();
  }

  /// Update connectivity status
  void setConnectivityStatus(ConnectivityStatus value) {
    connectivityStatus = value;
  }

  /// Monitor connectivity changes
  void checkConnection() {
    connectivityService.connectionStatus.listen((event) {
      setConnectivityStatus(event);
      isOnLine.value = event == ConnectivityStatus.online;
    });
  }

  /// Set search loading state
  void setSearching(bool value) {
    isSearching.value = value;
  }

  /// Update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  /// Clear search state
  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
    isSearching.value = false;
  }
}