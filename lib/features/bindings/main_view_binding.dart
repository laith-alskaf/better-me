import 'package:BetterMe/features/search_chat/index.dart';
import 'package:get/get.dart';

// Feature Bindings
import 'package:BetterMe/features/home/presentation/bindings/home_binding.dart';
import 'package:BetterMe/features/calculator/presentation/bindings/calculator_binding.dart';
import 'package:BetterMe/features/search_chat/presentation/bindings/search_binding.dart';
import 'package:BetterMe/features/medicine/presentation/bindings/medicine_binding.dart';

/// MainViewBinding
/// Initializes all controllers required by MainView and its child features
class MainViewBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize all feature controllers
    HomeBinding().dependencies();
    CalculatorBinding().dependencies();
    SearchBinding().dependencies();
    SearchChatBinding().dependencies();
    MedicineBinding().dependencies();
  }
}