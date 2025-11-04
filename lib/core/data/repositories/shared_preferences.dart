import 'package:get/get.dart';
import 'package:BetterMe/core/enums/data_type.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  late SharedPreferences _globalSharedPrefs;
  
  // Preference keys
  static const String prefImageList = 'image_list';
  static const String prefChatListAnswer = 'chat_list_answer';
  static const String prefChatListQuestions = 'chat_list_questions';
  
  SharedPreference() {
    _globalSharedPrefs = Get.find();
  }


  /// Save chat message list (answers)
  Future<void> setChatMessageListAnswer(List<String> list) async {
    await setPreference(
      dataType: DataType.stringList,
      key: prefChatListAnswer,
      value: list,
    );
  }

  /// Save chat message list (questions)
  Future<void> setChatMessageListQuestions(List<String> list) async {
    await setPreference(
      dataType: DataType.stringList,
      key: prefChatListQuestions,
      value: list,
    );
  }

  /// Get chat message list (answers)
  List<String> getChatMessageListAnswer() {
    if (_globalSharedPrefs.containsKey(prefChatListAnswer)) {
      return getPreference(key: prefChatListAnswer) ?? [];
    }
    return [];
  }

  /// Get chat message list (questions)
  List<String> getChatMessageListQuestions() {
    if (_globalSharedPrefs.containsKey(prefChatListQuestions)) {
      return getPreference(key: prefChatListQuestions) ?? [];
    }
    return [];
  }

  /// Get preference value from storage
  dynamic getPreference({required String key}) {
    return _globalSharedPrefs.getStringList(key);
  }

  /// Set preference value to storage
  Future<void> setPreference({
    required DataType dataType,
    required String key,
    required dynamic value,
  }) async {
    switch (dataType) {
      case DataType.int:
        await _globalSharedPrefs.setInt(key, value as int);
        break;
      case DataType.double:
        await _globalSharedPrefs.setDouble(key, value as double);
        break;
      case DataType.string:
        await _globalSharedPrefs.setString(key, value as String);
        break;
      case DataType.stringList:
        await _globalSharedPrefs.setStringList(key, value as List<String>);
        break;
      case DataType.bool:
        await _globalSharedPrefs.setBool(key, value as bool);
        break;
    }
  }
}
