import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/shared/widgets/buttons/app_button.dart';
import 'package:BetterMe/shared/widgets/common/app_text.dart';
import 'package:BetterMe/shared/widgets/cards/app_card.dart';
import '../theme/calculator_colors.dart';

/// CalculatorBaseView - Base template for all calculator screens
/// Provides consistent UI/UX, reduces code duplication
class CalculatorBaseView extends StatelessWidget {
  final String title;
  final Color accentColor;
  final Color? backgroundColorAppBar;
  final String? icon;
  final String? description;
  final List<Widget> inputFields;
  final VoidCallback onCalculate;
  final bool isLoading;

  const CalculatorBaseView({
    super.key,
    required this.title,
    required this.accentColor,
    required this.inputFields,
    required this.onCalculate,
    this.icon,
    this.backgroundColorAppBar,
    this.description,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final mutedColor = accentColor.withValues(alpha: 0.5);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: backgroundColorAppBar ?? Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: backgroundColorAppBar != null ? Colors.white : CalculatorColors.textPrimary,
            size: DesignSystem.iconBase,
          ),
          onPressed: Navigator.of(context).pop,
        ),
        title: AppText(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: backgroundColorAppBar != null ? Colors.white : accentColor,
          ),
        ),
        iconTheme: backgroundColorAppBar != null
            ? const IconThemeData(color: Colors.white)
            : IconThemeData(color: CalculatorColors.textPrimary),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(DesignSystem.base.toDouble()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with accent color
            Container(
              padding: EdgeInsets.all(DesignSystem.md.toDouble()),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(DesignSystem.radiusBase),
                border: Border.all(
                  color: mutedColor.withValues(alpha: 0.2),
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: EdgeInsets.all(DesignSystem.sm.toDouble()),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.08),
                        borderRadius:
                            BorderRadius.circular(DesignSystem.radiusMd),
                      ),
                      child: Icon(
                        Icons.calculate_rounded,
                        color: accentColor,
                        size: DesignSystem.iconMd,
                      ),
                    ),
                    SizedBox(width: DesignSystem.md.toDouble()),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                            height: 1.3,
                          ),
                        ),
                        if (description != null) ...[
                          SizedBox(height: 6.0),
                          AppText(
                            description!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: CalculatorColors.textSecondary,
                              height: 1.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: DesignSystem.xl.toDouble()),

            // Input fields section
            AppCard(
              padding: EdgeInsets.all(DesignSystem.md.toDouble()),
              child: Column(
                children: List.generate(
                  inputFields.length,
                  (index) => Column(
                    children: [
                      inputFields[index],
                      if (index < inputFields.length - 1)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: DesignSystem.md.toDouble(),
                          ),
                          child: Divider(
                            color: CalculatorColors.divider,
                            height: 0.5,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: DesignSystem.xl.toDouble()),

            // Calculate button
            AppButton(
              label: 'Calculate',
              onPressed: isLoading ? () {} : onCalculate,
              // style: ButtonStyle.solid,
              isLoading: isLoading,
              isEnabled: !isLoading,
              backgroundColor: accentColor,
              width: double.infinity,
              height: DesignSystem.buttonHeightBase,
            ),

            SizedBox(height: DesignSystem.xl.toDouble()),
          ],
        ),
      ),
    );
  }
}