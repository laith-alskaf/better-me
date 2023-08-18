import 'package:get/get.dart';
import 'package:BetterMe/core/enums/data_type.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferance {
  SharedPreferences globalSharedPrefs = Get.find();
  String PREF_IMAGE_LIST = 'image_list';
  String PREE_CHAT_LIST_ANSWER = 'chat_list_answer';
  String PREE_CHAT_LIST_QUESTIONS = 'chat_list_questions';


  void setChatMessageListAnswer(List<String> list) {
    setPerference(
      dataType: DataType.STRINGLIST,
      key: PREE_CHAT_LIST_ANSWER,
      value:list,
    );
  }
  void setChatMessageListQuestions(List<String> list) {
    setPerference(
      dataType: DataType.STRINGLIST,
      key: PREE_CHAT_LIST_QUESTIONS,
      value:list,
    );
  }

  List<String> getChatMessageListAnswer() {
    if (globalSharedPrefs.containsKey(PREE_CHAT_LIST_ANSWER)) {
      return getPrefernce(key: PREE_CHAT_LIST_ANSWER);
    } else {
      return [];
    }
  }
 List<String> getChatMessageListQuestions() {
    if (globalSharedPrefs.containsKey(PREE_CHAT_LIST_QUESTIONS)) {
      return getPrefernce(key: PREE_CHAT_LIST_QUESTIONS);
    } else {
      return [];
    }
  }


  dynamic getPrefernce({required String key}) {
    return globalSharedPrefs.getStringList(key);
  }

  setPerference({
    required DataType dataType,
    required String key,
    required dynamic value,
  }) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedPrefs.setInt(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedPrefs.setDouble(key, value);
        break;
      case DataType.STRING:
        await globalSharedPrefs.setString(key, value);
        break;
      case DataType.STRINGLIST:
        await globalSharedPrefs.setStringList(key, value);
        break;
      case DataType.BOOL:
        await globalSharedPrefs.setBool(key, value);
        break;
    }
  }
}
