import 'package:get/get.dart';

// Features Imports
import 'package:BetterMe/features/splash/presentation/pages/splash_view.dart';
import 'package:BetterMe/features/home/presentation/pages/home_view.dart';
import 'package:BetterMe/features/calculator/presentation/pages/calculator_main_view.dart';
import 'package:BetterMe/features/search_chat/presentation/pages/search_screen_view.dart';
import 'package:BetterMe/features/medicine/presentation/pages/medicine_view.dart';
import 'package:BetterMe/features/medicine/presentation/pages/new_entry_view.dart';
import 'package:BetterMe/features/main_view.dart';

// Bindings
import 'package:BetterMe/features/home/presentation/bindings/home_binding.dart';
import 'package:BetterMe/features/calculator/presentation/bindings/calculator_binding.dart';
import 'package:BetterMe/features/search_chat/presentation/bindings/search_binding.dart';
import 'package:BetterMe/features/medicine/presentation/bindings/medicine_binding.dart';
import 'package:BetterMe/features/bindings/main_view_binding.dart';

import 'app_routes.dart';

/// App Pages Configuration
/// ????? ???? ????? ??????? ???? bindings ?????? ???
class AppPages {
  AppPages._(); // Private constructor

  static final pages = [
    // Splash Screen
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      transition: Transition.fade,
    ),
    
    // Main View (Navigation Hub)
    GetPage(
      name: AppRoutes.mainView,
      page: () =>const  MainView(),
      binding: MainViewBinding(),
      transition: Transition.noTransition,
    ),
    
    // Home Feature
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    
    // Calculator Feature
    GetPage(
      name: AppRoutes.calculator,
      page: () => const CalculatorMainView(),
      binding: CalculatorBinding(),
      transition: Transition.rightToLeft,
    ),
    
    // Search & Chat Feature
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
      transition: Transition.rightToLeft,
    ),
    
    // Medicine Reminder Feature
    GetPage(
      name: AppRoutes.medicineReminder,
      page: () => const MedicineView(),
      binding: MedicineBinding(),
      transition: Transition.rightToLeft,
    ),
    
    GetPage(
      name: AppRoutes.addMedicine,
      page: () => NewEntryView(),
      binding: MedicineBinding(),
      transition: Transition.downToUp,
    ),
  ];
}
