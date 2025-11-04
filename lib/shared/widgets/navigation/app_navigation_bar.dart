import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/localization/localization_controller.dart';

/// عنصر الملاحة
class NavItem {
  final String label;
  final IconData? icon;
  final String? svgIcon;
  final int badgeCount;

  const NavItem({
    required this.label,
    this.icon,
    this.svgIcon,
    this.badgeCount = 0,
  });
}

/// AppNavigationBar - شريط ملاحة احترافي
class AppNavigationBar extends StatelessWidget {
  final List<NavItem> items;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final bool showLabels;

  const AppNavigationBar({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemTapped,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isArabic = LocalizationController.instance.isArabic;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.textLight.withValues(alpha: 0.1),
            width: DesignSystem.borderWidthBase,
          ),
        ),
        boxShadow: DesignSystem.shadowElevation8,
      ),
      child: BottomNavigationBar(
        backgroundColor: backgroundColor ?? AppColors.background,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: selectedColor ?? AppColors.primary,
        unselectedItemColor: unselectedColor ?? AppColors.textLight,
        elevation: 0,
        showSelectedLabels: showLabels,
        showUnselectedLabels: showLabels,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: DesignSystem.lineHeightTight,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: DesignSystem.lineHeightTight,
        ),
        items: List.generate(
          items.length,
          (index) => _buildNavItem(
            items[index],
            index == selectedIndex,
            isArabic,
          ),
        ),
        onTap: onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    NavItem item,
    bool isSelected,
    bool isArabic,
  ) {
    return BottomNavigationBarItem(
      icon: _buildIconWithBadge(
        item,
        isSelected,
        isArabic,
      ),
      activeIcon: _buildIconWithBadge(
        item,
        true,
        isArabic,
      ),
      label: item.label,
    );
  }

  Widget _buildIconWithBadge(
    NavItem item,
    bool isSelected,
    bool isArabic,
  ) {
    final icon = _buildIcon(item, isSelected, isArabic);

    if (item.badgeCount > 0) {
      return Stack(
        children: [
          icon,
          Positioned(
            right: isArabic ? null : 0,
            left: isArabic ? 0 : null,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: DesignSystem.xs,
                vertical: DesignSystem.xs,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(DesignSystem.radiusFull),
              ),
              child: Text(
                item.badgeCount > 99 ? '99+' : item.badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return icon;
  }

  Widget _buildIcon(NavItem item, bool isSelected, bool isArabic) {
    final color = isSelected ? AppColors.primary : AppColors.textLight;

    if (item.svgIcon != null) {
      return Container(
        padding: EdgeInsets.all(DesignSystem.sm),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
              )
            : null,
        child: SvgPicture.asset(
          item.svgIcon!,
          width: DesignSystem.iconMd,
          height: DesignSystem.iconMd,
        ),
      );
    } else if (item.icon != null) {
      return Container(
        padding: EdgeInsets.all(DesignSystem.sm),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
              )
            : null,
        child: Icon(
          item.icon,
          size: DesignSystem.iconMd,
          color: color,
        ),
      );
    }

    return const SizedBox();
  }
}
