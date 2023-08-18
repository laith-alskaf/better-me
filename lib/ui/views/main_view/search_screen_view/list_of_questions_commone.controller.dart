import 'package:get/get.dart';

class ListQuestionsCommone extends GetxController {
  RxList<List<String>>? listQuestionsAndAnswer;

  void removeInList(int index) {
    listQuestionsAndAnswer!.removeAt(index);
  }
  void addInList(String questions ,String answer ) {
    listQuestionsAndAnswer!.add([questions,answer]);
  }
}
