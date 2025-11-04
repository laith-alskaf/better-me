import 'package:get/get.dart';

/// ListQuestionsCommon Controller
/// Manages list of Q&A for common questions
class ListQuestionsCommon extends GetxController {
  RxList<List<String>> listQuestionsAndAnswer = RxList<List<String>>([]);

  void removeInList(int index) {
    if (index < listQuestionsAndAnswer.length) {
      listQuestionsAndAnswer.removeAt(index);
    }
  }

  void addInList(String questions, String answer) {
    listQuestionsAndAnswer.add([questions, answer]);
  }
}