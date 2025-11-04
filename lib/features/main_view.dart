import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';
import 'package:BetterMe/features/calculator/presentation/pages/calculator_main_view.dart';
import 'package:BetterMe/features/home/presentation/pages/home_view.dart';
import 'package:BetterMe/features/medicine/presentation/pages/medicine_view.dart';
import 'package:BetterMe/features/search_chat/presentation/pages/search_screen_view.dart';
import 'package:BetterMe/shared/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// Main Navigation View - Hub for all features
/// المحور الرئيسي للتنقل بين الميزات
class MainView extends StatefulWidget {
  final int? initialIndex;

  const MainView({
    Key? key,
    this.initialIndex,
  }) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// List of feature views - maintain order for navigation bar
  late final List<Widget> _views = [
    const HomeView(),
    const CalculatorMainView(),
    const SearchScreen(),
    const MedicineView(),
  ];

  /// Localization keys for titles - maintain order with _views
  final List<String> _titleKeys = [
    'home',
    'calculator',
    'search',
    'medicine',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppScaffoldAppBar(
        titleKey: _titleKeys[_currentIndex],
        elevation: DesignSystem.elevationNone,
        showBackButton: false,
      ),
      body: SafeArea(
        bottom: false,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: _views,
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  /// Build Bottom Navigation Bar with localized items
  Widget _buildBottomNavBar() {
    final List<NavItem> localizedNavItems = [
      NavItem(
        label: _titleKeys[0].tr,
        icon: Icons.home_rounded,
      ),
      NavItem(
        label: _titleKeys[1].tr,
        icon: Icons.calculate_rounded,
      ),
      NavItem(
        label: _titleKeys[2].tr,
        icon: Icons.search_rounded,
      ),
      NavItem(
        label: _titleKeys[3].tr,
        icon: Icons.medical_services_rounded,
      ),
    ];

    return AppNavigationBar(
      items: localizedNavItems,
      selectedIndex: _currentIndex,
      onItemTapped: (index) {
        setState(() {
          _currentIndex = index;
        });
        _pageController.jumpToPage(index);
      },
    );
  }
}
