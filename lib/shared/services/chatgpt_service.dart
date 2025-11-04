import 'package:get/get.dart';
import 'package:BetterMe/core/data/models/api/ChatGptModel.dart';
import 'package:BetterMe/core/data/repositories/chatgpt_repositiory.dart';
import 'package:BetterMe/core/enums/message_type.dart';
import 'package:BetterMe/core/widgets/custom_toast.dart';
import 'package:BetterMe/shared/utils/utils.dart';

class ChatGptService extends GetxController {
  String chatAnswer = "";
  RxList<String> chatListAnswer = storage.getChatMessageListAnswer().obs;
  RxList<String> chatListQuestions = storage.getChatMessageListQuestions().obs;
  String chatQuestions = "";
  RxBool isBusy = false.obs;
  String message ='';


  List<String> onInitChatListQuestions =
  [
    'faq_q1',
    'faq_q2',
    'faq_q3',
    'faq_q4',
    'faq_q5',
    'faq_q6',
    'faq_q7',
    'faq_q8',
  ];
  List<String> onInitChatListAnswer =
  [
    'faq_a1',
    'faq_a2',
    'faq_a3',
    'faq_a4',
    'faq_a5',
    'faq_a6',
    'faq_a7',
    'faq_a8',
  ];


  @override
  onInit() {
    if(chatListAnswer.isEmpty)
      {
        storage.setChatMessageListAnswer(onInitChatListAnswer);
        storage.setChatMessageListQuestions(onInitChatListQuestions);
        chatListAnswer=storage.getChatMessageListAnswer().obs;
        chatListQuestions = storage.getChatMessageListQuestions().obs;
      }
    // chatList = storage.getChatMessageList().obs;
    super.onInit();
  }

  Future getAnswer({required String messages}) async {
    message= messages;
    isBusy.value = true;
    ChatGPTRepositiory()
        .sendMessage(messages: messages)
        .then((value) => value.fold((l) {
              isBusy.value = false;
              CustomToast.showMessage(
                  message: "تأكد من اتصالك بالانترنت", messageType: MessageType.rejected);
            }, (r) {
              // chatMessage.addAll(r);
              chatAnswer = r[0].choices![0].message!.content.toString();
              if(isOnline&&r.isNotEmpty)
                {
                  getQuestionsGood(r);
                }
              else{
                isBusy.value = false;
                showNoConnectionMessage();
              }

            }));
  }

  void getQuestionsGood(List<ChatGptModel> r) {
    ChatGPTRepositiory()
        .sendMessage(messages: "اعطني سؤال بالفصحة حتى اضعه ضمن الاسئلة الشائعة بديل لهذا $message")
        .then((value) => value.fold((l) {
              isBusy.value = false;
              CustomToast.showMessage(
                  message: "تأكد من اتصالك بالانترنت", messageType: MessageType.rejected);
            }, (r) {
              chatQuestions = r[0].choices![0].message!.content.toString();
              if (chatQuestions.isNotEmpty && chatAnswer.isNotEmpty) {
                setChatMessageListAll();
                storage.setChatMessageListAnswer(chatListAnswer);
                storage.setChatMessageListQuestions(chatListQuestions);
                isBusy.value=false;

              }
            }));
  }

  void setChatMessageListAll() {
    chatListQuestions.insert(0,chatQuestions);
    chatListAnswer.insert(0,chatAnswer);
  }

  void removeQuestionsANDAnswer(int indexQuestions, int indexAnswer) {
    chatListQuestions.removeAt(indexQuestions);
    chatListAnswer.removeAt(indexAnswer);
    storage.setChatMessageListAnswer(chatListAnswer);
    storage.setChatMessageListQuestions(chatListQuestions);
  }
}