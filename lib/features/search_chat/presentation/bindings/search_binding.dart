import 'package:get/get.dart';
import 'package:BetterMe/shared/services/chatgpt_service.dart';
import '../controllers/search_chatgpt_controller.dart';
import '../controllers/search_controller.dart';

/// Binding للبحث والدردشة
/// يدير تهيئة SearchChatgptController و ListQuestionsCommon
class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchChatgptController>(
      () => SearchChatgptController(),
      fenix: true,
    );
    Get.lazyPut<ListQuestionsCommon>(
      () => ListQuestionsCommon(),
      fenix: true,
    );
    Get.lazyPut<ChatGptService>(
      () => ChatGptService(),
      fenix: true,
    );
  }
}