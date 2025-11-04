import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import '../controllers/search_chatgpt_controller.dart';
import '../widgets/index.dart';

/// SearchChatGPT View - صفحة البحث الذكي مع الذكاء الاصطناعي
/// تسمح للمستخدم بطرح أسئلة والحصول على إجابات من ChatGPT
class SearchChatGPTView extends GetView<SearchChatgptController> {
  const SearchChatGPTView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController questionsController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppScaffoldAppBar(
        titleKey: 'ask_ai_question'.tr,
        elevation: DesignSystem.elevationMedium,
      ),
      body: Column(
        children: [
          // Hero Section
          _buildHeroSection(),

          // Main Content
          Expanded(
            child: Obx(() {
              // Determine current state
              if (controller.isSearching.value && controller.searchResults.isEmpty) {
                return _buildLoadingState();
              }

              if (controller.searchResults.isNotEmpty) {
                return _buildResultsView();
              }

              // Initial/Empty State
              return _buildInitialState();
            }),
          ),

          // Input Section (Always at bottom)
          _buildInputSection(questionsController),
        ],
      ),
    );
  }

  /// بناء قسم Hero الجذاب
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.base,
        vertical: DesignSystem.xl,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.8),
          ],
        ),
        boxShadow: DesignSystem.shadowElevation8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with animation hint
          Container(
            padding: EdgeInsets.all(DesignSystem.base),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 40.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: DesignSystem.md),
          // Title
          Text(
            'what_do_you_want_to_know'.tr,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: DesignSystem.sm),
          // Subtitle
          Text(
            'ask_health_questions'.tr,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.85),
              height: DesignSystem.lineHeightRelaxed,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// الحالة الأولية - بدون بحث
  Widget _buildInitialState() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DesignSystem.base,
            vertical: DesignSystem.xxxl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Decorative Icon
              Container(
                padding: EdgeInsets.all(DesignSystem.xl),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 50.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: DesignSystem.xxl),
              // Message
              Text(
                'start_asking'.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: DesignSystem.base),
              Text(
                'ask_anything_health'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  height: DesignSystem.lineHeightRelaxed,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: DesignSystem.xxl),
              // Quick tips
              _buildQuickTips(),
            ],
          ),
        ),
      ),
    );
  }

  /// نصائح سريعة للاستخدام
  Widget _buildQuickTips() {
    final tips = [
      'Tip: Ask about health conditions',
      'Tip: Ask about symptoms',
      'Tip: Ask about treatments',
    ];

    return Column(
      children: tips.asMap().entries.map((entry) {
        final tip = entry.value;
        return Padding(
          padding: EdgeInsets.only(bottom: DesignSystem.base),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: DesignSystem.base,
              vertical: DesignSystem.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.stars_rounded,
                  size: 16.sp,
                  color: AppColors.primary,
                ),
                SizedBox(width: DesignSystem.sm),
                Text(
                  tip,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  /// حالة التحميل
  Widget _buildLoadingState() {
    return const SearchLoadingState(
      messageKey: 'searching_answer',
    );
  }

  /// عرض النتائج
  Widget _buildResultsView() {
    return Obx(
      () => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: DesignSystem.base,
          vertical: DesignSystem.base,
        ),
        child: Column(
          children: [
            // Result Header
            _buildResultHeader(),
            SizedBox(height: DesignSystem.lg),
            // Results List
            ...controller.searchResults.asMap().entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(bottom: DesignSystem.lg),
                child: SearchResultCard(
                  question: 'Search Result ${entry.key + 1}',
                  answer: entry.value,
                ),
              );
            }),
            SizedBox(height: DesignSystem.xl),
          ],
        ),
      ),
    );
  }

  /// رأس النتائج
  Widget _buildResultHeader() {
    return Container(
      padding: EdgeInsets.all(DesignSystem.base),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.success,
            size: 20.sp,
          ),
          SizedBox(width: DesignSystem.base),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'answer_found'.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
                SizedBox(height: DesignSystem.xs),
                Text(
                  'thank_you_for_asking'.tr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// قسم الإدخال في الأسفل
  Widget _buildInputSection(TextEditingController questionsController) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DesignSystem.base,
        vertical: DesignSystem.base,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant,
            width: 1,
          ),
        ),
        boxShadow: DesignSystem.shadowElevation4,
      ),
      child: Row(
        children: [
          // Search Input Field
          Expanded(
            child: AppTextFormField(
              controller: questionsController,
              hintText: 'ask_question'.tr,
              prefixIcon: Icon(
                Icons.search_rounded,
                color: AppColors.primary,
              ),
              borderRadius: DesignSystem.radiusBase,
              contentPadding: EdgeInsets.symmetric(
                horizontal: DesignSystem.base,
                vertical: DesignSystem.base,
              ),
            ),
          ),
          SizedBox(width: DesignSystem.base),
          // Send Button
          Obx(
            () =>  Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
                boxShadow: DesignSystem.shadowElevation4,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: controller.isSearching.value
                      ? null
                      : () {
                          if (questionsController.text.isNotEmpty) {
                            controller.updateSearchQuery(
                              questionsController.text,
                            );
                            // Simulate search
                            controller.setSearching(true);
                            Future.delayed(const Duration(seconds: 2), () {
                              controller.setSearching(false);
                            });
                          }
                        },
                  borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
                  child: Padding(
                    padding: EdgeInsets.all(DesignSystem.base),
                    child: controller.isSearching.value
                        ? SizedBox(
                            width: 24.sp,
                            height: 24.sp,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}