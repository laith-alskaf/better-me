import 'package:get/get.dart';
import 'package:BetterMe/core/data/models/api/ChatGptModel.dart';
import 'package:BetterMe/core/data/repositories/chatgpt_repositiory.dart';
import 'package:BetterMe/core/enums/message_type.dart';
import 'package:BetterMe/ui/shared/custom_widget/custom_toast.dart';
import 'package:BetterMe/ui/shared/utils.dart';

class ChatGptService extends GetxController {
  String chatAnswer = "";
  RxList<String> chatListAnswer = storage.getChatMessageListAnswer().obs;
  RxList<String> chatListQuestions = storage.getChatMessageListQuestions().obs;
  String chatQuestions = "";
  RxBool isBusy = false.obs;
  String message ='';


  List<String> onInitChatListQuestions =
  [
    'ما هي أهمية الحمية الصحية؟',
    'ما هي الأدوية المستخدمة لعلاج نزلات البرد؟',
    'ما هي الأمراض الشائعة في فصل الشتاء؟',
    'هل يمكن استخدام الأدوية المضادة للالتهابات بدون وصفة طبية؟',
    'هل يمكن الوقاية من الأمراض المعدية عن طريق التطعيم؟',
    'ما هي أهمية النوم الجيد في صحتنا؟',
    'هل يؤثر التوتر النفسي على الصحة؟',
    'ما هي أهمية ممارسة التمارين الرياضية بانتظام؟',
  ];
  List<String> onInitChatListAnswer =
  [
    'الحمية الصحية تلعب دورًا هامًا في المحافظة على الصحة والوقاية من الأمراض.',
    'يمكن استخدام الأدوية المسكنة لتخفيف أعراض نزلات البرد مثل الصداع والحمى.',
    'بعض الأمراض الشائعة في فصل الشتاء تشمل الإنفلونزا ونزلات البرد والتهاب الحلق.',
    'تعتبر الأدوية المضادة للالتهابات من الأدوية الموصوفة عادةً، ويجب استشارة الطبيب قبل استخدامها.',
    'نعم، التطعيم يعتبر وسيلة فعالة للوقاية من الأمراض المعدية.',
    'النوم الجيد يلعب دورًا هامًا في تجديد الجسم واستعادة الطاقة وتعزيز الصحة العامة.',
    'نعم، التوتر النفسي المستمر قد يؤدي إلى مشاكل صحية مثل ارتفاع ضغط الدم وأمراض القلب.',
    'ممارسة التمارين الرياضية بانتظام تساهم في تحسين اللياقة البدنية والقوة والمرونة والتوازن.',
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
                  message: "تأكد من اتصالك بالانترنت", messageType: MessageType.REJECTED);
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
                  message:"تأكد من اتصالك بالانترنت", messageType: MessageType.REJECTED);
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
