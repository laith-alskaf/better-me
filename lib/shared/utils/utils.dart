import 'package:BetterMe/core/enums/connectivity_status.dart';
import 'package:BetterMe/core/enums/message_type.dart';
import 'package:BetterMe/core/services/connectivity_service.dart';
import 'package:BetterMe/core/widgets/custom_toast.dart';
import 'package:BetterMe/features/search_chat/presentation/controllers/search_chatgpt_controller.dart';
import 'package:get/get.dart';
import 'package:BetterMe/core/data/repositories/shared_preferences.dart';

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);
  }
}

//____________________________________________________________________________________________
bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}
//___________________________________________________________________________________________

bool checkAge(String age) {
  RegExp regex = RegExp(r'^(1[89]|[2-9]\d|\d{3,})$');
  // يتطلب العمر أن يكون 18 عامًا أو أكثر
  // سيتوافق النمط النمطي مع الأعداد بين 18 وأعلى
  return regex.hasMatch(age);
}

//_______________________________________________________________________________________________

bool isValidSyriaMobileNumber(String mobileNumber) {
  RegExp regex = RegExp(r'^(!?(\+|00)?(963)|0)?9\d{8}$');
  return regex.hasMatch(mobileNumber);
}

//___________________________________________________________________________________________

bool isValidPassword(String password, String confirmPassword) {
  RegExp regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$');
  return (password == confirmPassword) && regex.hasMatch(password);
}

//_________________________________________________________________________________

bool isValidName(String em) {
  String p = r'^[a-zA-Z]+(?:\s+[a-zA-Z]+)*$';
  RegExp regExp = RegExp(p);
  return regExp.hasMatch(em);
}
//__________________________________________________________________________________________
// bool validateEmail(String value) {
//   Pattern pattern =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   RegExp regex = new RegExp(pattern);
//   return (!regex.hasMatch(value)) ? false : true;
// }

//_______________________________________________________________________________________

// r'^
// (?=.*[A-Z])       // should contain at least one upper case
// (?=.*[a-z])       // should contain at least one lower case
// (?=.*?[0-9])      // should contain at least one digit
// (?=.*?[!@#\$&*~]) // should contain at least one Special character
//     .{8,}             // Must be at least 8 characters in length
// $
//_________________________________________________________________________________

bool validatePassword(String value) {
  String regex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(regex);
  return regExp.hasMatch(value);
}
double screenWidth(percent) {
  return Get.size.width / percent;
}

double screenHeight(percent) {
  return Get.size.width / percent;
}

double get width => Get.size.width;

double get height => Get.size.height;


//___________________________________________________________________________
// void customLoader() => BotToast.showCustomLoading(toastBuilder: (context) {
//       return Container(
//         decoration: BoxDecoration(
//             color: Colors.white10,
//             borderRadius: BorderRadius.circular(10)),
//         width: screenWidth(4),
//         height: screenHeight(4),
//         child: SpinKitCircle(
//           color:const Color.fromRGBO(187, 229, 169, 1),
//           size: screenWidth(8),
//         ),
//       );
//     });
//___________________________________________________________
SharedPreference get storage => Get.find<SharedPreference>();
ConnectivityService get connectivityService => Get.find<ConnectivityService>();
SearchChatgptController get searchChatgptController => Get.find<SearchChatgptController>();

bool get isOnline =>
    searchChatgptController.connectivityStatus == ConnectivityStatus.online;

bool get isOffline =>
    searchChatgptController.connectivityStatus == ConnectivityStatus.offline;


void showNoConnectionMessage() {
  CustomToast.showMessage(
      message: 'رجائاً تأكد من اتصالك بالانترنت',
      messageType: MessageType.rejected);
}

void checkConnection(Function function) {
  if (isOnline) {
    function();
  } else {
    showNoConnectionMessage();
  }
}