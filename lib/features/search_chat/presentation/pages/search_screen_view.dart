import 'package:BetterMe/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:BetterMe/shared/services/chatgpt_service.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import '../controllers/search_chatgpt_controller.dart';
import '../widgets/index.dart';
import 'search_chatgpt_view.dart';

/// SearchScreen View - صفحة الأسئلة الشائعة
/// يعرض قائمة الأسئلة الشائعة مع خيار البحث عن طريق الذكاء الاصطناعي
class SearchScreen extends GetView<SearchChatgptController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatGptService = Get.find<ChatGptService>();
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      // appBar: AppScaffoldAppBar(
      //   titleKey: 'common_faqs',
      //   elevation: DesignSystem.elevationMedium,
      //   actions: [
      //     // زر الدردشة مع الذكاء الاصطناعي
      //     _buildChatActionButton(chatGptService),
      //   ],
      // ),
      body: Obx(
        () => chatGptService.chatListQuestions.isEmpty
            ? _buildLoadingState()
            : _buildContent(chatGptService, searchController),
      ),
    );
  }

  /// بناء محتوى الصفحة الرئيسي
  Widget _buildContent(
    ChatGptService chatGptService,
    TextEditingController searchController,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Search Input Widget
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DesignSystem.base),
            child: SearchInputWidget(
              controller: searchController,
              hintTextKey: 'search_placeholder_faq',
              onSearchPressed: () {
                // يمكن إضافة منطق البحث المتقدم هنا
              },
              onChatActionButton: () {
                if (isOnline) {
                  chatGptService.isBusy.value = false;
                  Get.to(
                    const SearchChatGPTView(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 400),
                  );
                } else {
                  ScaffoldMessenger.of(Get.context!).showSnackBar(
                    SnackBar(
                      content: AppText('no_internet'.tr),
                      backgroundColor: AppColors.error,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ),

       const   SizedBox(height: DesignSystem.xl),

          // Section Header with Result Count
          _buildSectionHeader(chatGptService),

       const   SizedBox(height: DesignSystem.base),

          // FAQ List
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: DesignSystem.base),
            child: _buildFAQListView(chatGptService),
          ),

        const  SizedBox(height: DesignSystem.xxxl),
        ],
      ),
    );
  }

  /// بناء رأس القسم مع عدد النتائج
  Widget _buildSectionHeader(ChatGptService chatGptService) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: DesignSystem.base),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'popular_questions'.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            const  SizedBox(height: DesignSystem.xs),
              Text(
                'tap_to_see_answers'.tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          // Result Badge
          Container(
            padding:const EdgeInsets.symmetric(
              horizontal: DesignSystem.base,
              vertical: DesignSystem.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColors.primary,
                  size: 16.sp,
                ),
               const SizedBox(width: DesignSystem.xs),
                Text(
                  '${chatGptService.chatListQuestions.length}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// بناء ListView الأسئلة الشائعة
  Widget _buildFAQListView(ChatGptService chatGptService) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: chatGptService.chatListQuestions.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:const EdgeInsets.only(bottom: DesignSystem.base),
          child: FAQItemWidget(
            question: chatGptService.chatListQuestions[index].tr,
            answer: chatGptService.chatListAnswer[index].tr,
            index: index,
          ),
        );
      },
    );
  }

  /// بناء حالة التحميل
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Loading Icon
          Container(
            padding:const EdgeInsets.all(DesignSystem.xl),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 50.sp,
              height: 50.sp,
              child: const CircularProgressIndicator(
                strokeWidth: 3.5,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
        const  SizedBox(height: DesignSystem.xl),
          // Loading Text
          Text(
            'loading_faqs'.tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        const  SizedBox(height: DesignSystem.sm),
          Text(
            'please_wait'.tr,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
