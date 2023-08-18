import 'package:BetterMe/ui/views/main_view/search_screen_view/search_chatgpt_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BetterMe/ui/servace/chatgpt_service.dart';
import 'package:BetterMe/ui/shared/custom_widget/custom_text_form_field.dart';
import 'package:BetterMe/ui/shared/custom_widget/faq_item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:BetterMe/ui/shared/utils.dart';

class SearchChatGPTView extends StatefulWidget {
  const SearchChatGPTView({Key? key}) : super(key: key);

  @override
  State<SearchChatGPTView> createState() => _SearchChatGPTViewState();
}

class _SearchChatGPTViewState extends State<SearchChatGPTView> {
  ChatGptService? controllerChat;

  @override
  void initState() {
    // TODO: implement initState
    controllerChat = Get.put(ChatGptService());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllerChat!.message = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchChatgptController controllerConection=Get.put(SearchChatgptController());
    final TextEditingController questionsController = TextEditingController();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text('البحث '),
          backgroundColor: const Color.fromRGBO(187, 229, 169, 1)),
      body: ListView(
        shrinkWrap: true,
        children: [
          Obx(
            () => TextFormFieldSIgnUP(
              hintText: "ماذا تريد ان تعرف ؟",
              hintTextStyle: const TextStyle(color: Colors.white),
              controller: questionsController,
              readOnly: controllerChat!.isBusy.value ? true : false,
              prefixIcon: controllerChat!.isBusy.value
                  ? const SizedBox(
                      width: 0,
                      height: 0,
                    )
                  :
              InkWell(
                      onTap: () {
                        // controllerConection.checkConnection();
                        if(isOnline)
                          {
                            controllerChat!
                                .getAnswer(messages: questionsController.text);
                            questionsController.clear();
                          }
                        else{
                          showNoConnectionMessage();
                        }

                          // controllerChat!
                          //          .getAnswer(messages: questionsController.text);
                          //    questionsController.clear();
                      },
                      child: const Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => controllerChat!.isBusy.value
                ? Column(
                    children: [
                      const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child:  Text(
                            'شكرًا لك على إرسال استفسارك. نحن نحاول جاهدين لتوفير الإجابة المناسبة لك في أقرب وقت ممكن.يرجى الانتظار بضع دقائق حتى يتم الرد عليك. نحن نقدر صبرك وتفهمك',
                            style: TextStyle(
                                fontSize: 20, ),textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight(2.3)),
                        child: const SpinKitThreeBounce(
                          color: Color.fromRGBO(187, 229, 169, 1),
                          size: 80.0,
                        ),
                      ),

                    ],
                  )
                : FAQItem(
                    chatGPtShowMessage: true,
                    question: controllerChat!.chatListQuestions[0],
                    answer: controllerChat!.chatListAnswer[0],
                  ),
          )
        ],
      ),
    ));
  }
}
