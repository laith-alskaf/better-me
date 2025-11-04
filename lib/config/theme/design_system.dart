import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// DesignSystem - نظام التصميم الموحد للتطبيق
/// يحتوي على جميع الثوابت المتعلقة بالتصميم: الفراغات والأحجام والحدود
/// يدعم القيم المتجاوبة عبر Sizer
class DesignSystem {
  DesignSystem._(); // Private constructor

  // ===== SPACING CONSTANTS =====
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double base = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 48.0;

  // ===== PADDING & MARGIN SHORTCUTS =====
  static final EdgeInsets paddingXs = EdgeInsets.all(xs);
  static final EdgeInsets paddingSm = EdgeInsets.all(sm);
  static final EdgeInsets paddingMd = EdgeInsets.all(md);
  static final EdgeInsets paddingBase = EdgeInsets.all(base);
  static final EdgeInsets paddingLg = EdgeInsets.all(lg);
  static final EdgeInsets paddingXl = EdgeInsets.all(xl);

  static final EdgeInsets paddingSymmetricXs =
      EdgeInsets.symmetric(horizontal: xs, vertical: xs);
  static final EdgeInsets paddingSymmetricSm =
      EdgeInsets.symmetric(horizontal: sm, vertical: sm);
  static final EdgeInsets paddingSymmetricMd =
      EdgeInsets.symmetric(horizontal: md, vertical: md);
  static final EdgeInsets paddingSymmetricBase =
      EdgeInsets.symmetric(horizontal: base, vertical: base);

  static final EdgeInsets paddingSymmetricHorizontalBase =
      EdgeInsets.symmetric(horizontal: base);
  static final EdgeInsets paddingSymmetricHorizontalLg =
      EdgeInsets.symmetric(horizontal: lg);
  static final EdgeInsets paddingSymmetricVerticalBase =
      EdgeInsets.symmetric(vertical: base);

  // ===== BORDER RADIUS =====
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusBase = 16.0;
  static const double radiusLg = 20.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 9999.0;

  static final BorderRadius borderRadiusXs = BorderRadius.circular(radiusXs);
  static final BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static final BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static final BorderRadius borderRadiusBase =
      BorderRadius.circular(radiusBase);
  static final BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);
  static final BorderRadius borderRadiusXl = BorderRadius.circular(radiusXl);
  static final BorderRadius borderRadiusFull =
      BorderRadius.circular(radiusFull);

  // ===== ICON SIZES =====
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconBase = 28.0;
  static const double iconLg = 32.0;
  static const double iconXl = 40.0;
  static const double iconXxl = 48.0;

  // ===== BUTTON SIZES =====
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightBase = 44.0;
  static const double buttonHeightLarge = 52.0;
  static const double buttonHeightExtraLarge = 60.0;

  static const double buttonPaddingHorizontalSm = 12.0;
  static const double buttonPaddingHorizontalBase = 16.0;
  static const double buttonPaddingHorizontalLg = 20.0;

  static const double buttonPaddingVerticalSm = 8.0;
  static const double buttonPaddingVerticalBase = 12.0;
  static const double buttonPaddingVerticalLg = 16.0;

  // ===== INPUT FIELD SIZES =====
  static const double inputFieldHeight = 48.0;
  static const double inputFieldHeightDense = 40.0;
  static const double inputFieldPadding = 12.0;
  static const double inputFieldBorderRadius = 12.0;

  // ===== SHADOW CONFIGURATIONS =====
  static const List<BoxShadow> shadowElevation1 = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 1.0,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> shadowElevation2 = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 2.0,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> shadowElevation4 = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 4.0,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadowElevation8 = [
    BoxShadow(
      color: Color(0x24000000),
      blurRadius: 8.0,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> shadowElevation12 = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 12.0,
      offset: Offset(0, 6),
    ),
  ];

  static const List<BoxShadow> shadowElevation16 = [
    BoxShadow(
      color: Color(0x3D000000),
      blurRadius: 16.0,
      offset: Offset(0, 8),
    ),
  ];

  // ===== BORDER WIDTHS =====
  static const double borderWidthThin = 0.5;
  static const double borderWidthBase = 1.0;
  static const double borderWidthMedium = 1.5;
  static const double borderWidthThick = 2.0;

  // ===== ANIMATION DURATIONS =====
  static const Duration animationDurationFast = Duration(milliseconds: 150);
  static const Duration animationDurationNormal = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);
  static const Duration animationDurationXl = Duration(milliseconds: 750);

  // ===== ANIMATION CURVES =====
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveLinear = Curves.linear;
  static const Curve curveBounce = Curves.bounceOut;
  static const Curve curveElastic = Curves.elasticOut;

  // ===== DEVICE SAFE AREA PADDING =====
  static const double safeAreaPaddingTop = 16.0;
  static const double safeAreaPaddingBottom = 16.0;
  static const double safeAreaPaddingHorizontal = 16.0;

  // ===== Z-INDEX / ELEVATION =====
  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationVeryHigh = 16.0;

  // ===== OPACITY =====
  static const double opacityDisabled = 0.38;
  static const double opacityHint = 0.60;
  static const double opacitySecondary = 0.72;
  static const double opacityFull = 1.0;

  // ===== LINE HEIGHT =====
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;
  static const double lineHeightLoose = 2.0;

  // ===== TEXT STYLES =====
  static const TextStyle headingBold = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    height: lineHeightNormal,
  );

  static const TextStyle headingSemiBold = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: lineHeightNormal,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    height: lineHeightRelaxed,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: lineHeightRelaxed,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    height: lineHeightRelaxed,
  );

  // ===== UTILITY METHODS =====

  /// إنشاء padding أفقي مخصص
  static EdgeInsets paddingHorizontal(double value) =>
      EdgeInsets.symmetric(horizontal: value);

  /// إنشاء padding عمودي مخصص
  static EdgeInsets paddingVertical(double value) =>
      EdgeInsets.symmetric(vertical: value);

  /// إنشاء border radius مخصص
  static BorderRadius borderRadius(double value) =>
      BorderRadius.circular(value);

  /// إنشاء shadow مخصص
  static List<BoxShadow> customShadow({
    required Color color,
    required double blurRadius,
    Offset offset = const Offset(0, 2),
    double spreadRadius = 0,
  }) =>
      [
        BoxShadow(
          color: color,
          blurRadius: blurRadius,
          offset: offset,
          spreadRadius: spreadRadius,
        ),
      ];

  // ===== RESPONSIVE SIZES (using Sizer) =====

  /// الحصول على حجم محسوب بناءً على عرض الشاشة (Responsive Width)
  /// مثالاً: getResponsiveWidth(50) = 50% من عرض الشاشة
  static double getResponsiveWidth(double percentage) {
    return percentage.w;
  }

  /// الحصول على حجم محسوب بناءً على ارتفاع الشاشة (Responsive Height)
  /// مثالاً: getResponsiveHeight(30) = 30% من ارتفاع الشاشة
  static double getResponsiveHeight(double percentage) {
    return percentage.h;
  }

  /// الحصول على حجم الخط محسوب بناءً على حجم الشاشة
  /// مثالاً: getResponsiveFontSize(4) = 4% من أصغر بُعد في الشاشة
  static double getResponsiveFontSize(double percentage) {
    return percentage.sp;
  }

  /// فراغ محسوب بناءً على عرض الشاشة
  static double getResponsivePadding(double percentage) {
    return getResponsiveWidth(percentage);
  }

  /// حجم Icon محسوب
  static double getResponsiveIconSize(double percentage) {
    return percentage.sp;
  }

  /// حجم زر محسوب
  static double getResponsiveButtonHeight(double percentage) {
    return percentage.h;
  }

  // ===== PREDEFINED RESPONSIVE VALUES =====

  /// Responsive Paddings (اختيار تلقائي بناءً على حجم الشاشة)
  static EdgeInsets get responsivePaddingBase {
    return EdgeInsets.all(base.w);
  }

  static EdgeInsets get responsivePaddingSmall {
    return EdgeInsets.all(sm.w);
  }

  static EdgeInsets get responsivePaddingLarge {
    return EdgeInsets.all(lg.w);
  }

  static EdgeInsets get responsivePaddingHorizontal {
    return EdgeInsets.symmetric(horizontal: base.w);
  }

  static EdgeInsets get responsivePaddingVertical {
    return EdgeInsets.symmetric(vertical: base.h);
  }

  /// Responsive Text Styles
  static TextStyle get headingResponsive {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      height: lineHeightNormal,
    );
  }

  static TextStyle get bodyResponsiveLarge {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      height: lineHeightRelaxed,
    );
  }

  static TextStyle get bodyResponsiveMedium {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      height: lineHeightRelaxed,
    );
  }

  static TextStyle get bodyResponsiveSmall {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      height: lineHeightRelaxed,
    );
  }

  /// Responsive Button Heights
  static double get buttonHeightResponsive {
    return 6.h;
  }

  /// Responsive Border Radius
  static double get borderRadiusResponsive {
    return 4.w;
  }

  /// Responsive Icon Size
  static double get iconSizeResponsive {
    return 8.w;
  }

  /// Responsive Divider/Separator Height
  static double get separatorHeight {
    return 1.h;
  }

  /// Responsive Card Padding
  static EdgeInsets get cardResponsivePadding {
    return EdgeInsets.all(4.w);
  }

  /// Responsive Grid Spacing
  static double get gridSpacingResponsive {
    return 2.w;
  }

  // ===== MODERN DESIGN TOKENS (Material Design 3) =====

  /// Gradient Definitions for Modern Aesthetic
  static LinearGradient get gradientPrimary {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF7CBD43),      // Primary green
        Color(0xFF68A940),      // Darker green
      ],
    );
  }

  static LinearGradient get gradientSecondary {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF8B7FBD),      // Secondary purple
        Color(0xFF6B67A5),      // Darker purple
      ],
    );
  }

  static LinearGradient get gradientAccent {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF7CBD43),      // Primary
        Color(0xFF8B7FBD),      // Secondary
      ],
    );
  }

  /// Modern Smooth Transitions for UI Elements
  static List<BoxShadow> get shadowModernLight {
    return [
      BoxShadow(
        color: Color(0x0F000000),
        blurRadius: 3.0,
        offset: Offset(0, 1),
      ),
    ];
  }

  static List<BoxShadow> get shadowModernMedium {
    return [
      BoxShadow(
        color: Color(0x14000000),
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ];
  }

  static List<BoxShadow> get shadowModernHigh {
    return [
      BoxShadow(
        color: Color(0x21000000),
        blurRadius: 12.0,
        offset: Offset(0, 4),
      ),
    ];
  }

  static List<BoxShadow> get shadowModernExtraHigh {
    return [
      BoxShadow(
        color: Color(0x2D000000),
        blurRadius: 20.0,
        offset: Offset(0, 8),
      ),
    ];
  }

  /// Modern Border Radius (Material Design 3 style)
  static const double radiusModernSmall = 8.0;
  static const double radiusModernMedium = 12.0;
  static const double radiusModernLarge = 16.0;
  static const double radiusModernExtraLarge = 20.0;
  static const double radiusModernMax = 28.0;

  static final BorderRadius borderRadiusModernSmall =
      BorderRadius.circular(radiusModernSmall);
  static final BorderRadius borderRadiusModernMedium =
      BorderRadius.circular(radiusModernMedium);
  static final BorderRadius borderRadiusModernLarge =
      BorderRadius.circular(radiusModernLarge);
  static final BorderRadius borderRadiusModernExtraLarge =
      BorderRadius.circular(radiusModernExtraLarge);

  /// Modern Transitions for Smooth Animations
  static const Duration transitionShort = Duration(milliseconds: 200);
  static const Duration transitionMedium = Duration(milliseconds: 300);
  static const Duration transitionLong = Duration(milliseconds: 500);

  static const Curve curveSmooth = Curves.easeInOut;
  static const Curve curveSmoothIn = Curves.easeIn;
  static const Curve curveSmoothOut = Curves.easeOut;
}
