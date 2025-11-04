import 'package:BetterMe/features/search_chat/index.dart';
import 'package:BetterMe/shared/services/chatgpt_service.dart';
import 'package:get/get.dart';

/// SearchChatBinding
/// GetX dependency injection binding for SearchChat feature
class SearchChatBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ إضافة fenix: true لمنع خطأ GetX عند العودة للصفحة
    Get.lazyPut<ListQuestionsCommon>(
      () => ListQuestionsCommon(),
      fenix: true,
    );
    Get.lazyPut<SearchChatgptController>(
      () => SearchChatgptController(),
      fenix: true,
    );
    Get.lazyPut<ChatGptService>(
      () => ChatGptService(),
      fenix: true,
    );
  }
}