import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// SplashView
/// شاشة البداية / التحميل للتطبيق
/// تعرض الشعار والأنيميشن مع مؤشر التحميل
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToHome();
  }

  /// إعداد الأنيميشنات
  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  /// التنقل إلى الشاشة الرئيسية بعد انتظار
  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Get.offAllNamed('/main');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary50,
      body: Container(
        // خلفية متدرجة محسّنة
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary50,
              AppColors.background,
              AppColors.primary50.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الشعار الرئيسي مع animation
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: _buildLogoContainer(),
                  ),

                  // المسافة
                  SizedBox(height: 8.h),

                  // اسم التطبيق
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'BetterMe',
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            offset: const Offset(0, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // الشعار الفرعي
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'صحتك أولاً'.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  // المسافة
                  SizedBox(height: 10.h),

                  // مؤشر التحميل
                  SpinKitCircle(
                    color: AppColors.primary,
                    size: 50.sp,
                  ),

                  // المسافة
                  SizedBox(height: 4.h),

                  // نص التحميل
                  Text(
                    'جاري التحميل...'.tr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// بناء حاوية اللوغو مع تأثيرات احترافية
  Widget _buildLogoContainer() {
    return Container(
      // حجم متناسب مع جميع الشاشات
      width: 65.w, // 65% من عرض الشاشة
      height: 65.w, // مربع متساوي الأبعاد
      constraints: BoxConstraints(
        maxWidth: 280, // حد أقصى للشاشات الكبيرة
        maxHeight: 280,
        minWidth: 200, // حد أدنى للشاشات الصغيرة
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        // خلفية بيضاء مع شفافية خفيفة
        color: AppColors.background,
        // شكل دائري احترافي
        shape: BoxShape.circle,
        // ظل ثلاثي الطبقات للعمق
        boxShadow: [
          // ظل خارجي كبير
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 40,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
          // ظل متوسط
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
          // ظل داخلي صغير
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
        // حدود ملونة خفيفة
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.1),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Container(
          // padding داخلي خفيف
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            // gradient خفيف للخلفية
            gradient: RadialGradient(
              colors: [
                AppColors.background,
                AppColors.primary50.withValues(alpha: 0.1),
              ],
              center: Alignment.center,
              radius: 1.0,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'images/logo.jpg',
              fit: BoxFit.cover, // تغطية كاملة
              // placeholder أثناء التحميل
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.primary50,
                  child: Icon(
                    Icons.health_and_safety_rounded,
                    size: 35.w,
                    color: AppColors.primary,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}