import 'package:BetterMe/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:BetterMe/ui/servace/chatgpt_service.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:BetterMe/ui/shared/custom_widget/faq_item.dart';
import 'package:BetterMe/ui/views/main_view/search_screen_view/search.chatgpt.view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ListQuestionsCommone? controller;

  ChatGptService? controllerChat;

  @override
  void initState() {
    // TODO: implement initState
    controllerChat = Get.put(ChatGptService());
    // controller = Get.put(ListQuestionsCommone());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title:const Text('أسئلة شائعة'),
          backgroundColor: const Color.fromRGBO(187, 229, 169, 1),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if(isOnline)
                  {
                    controllerChat!.isBusy.value=false;
                    Get.to(const SearchChatGPTView());
                  }
                else{
                  showNoConnectionMessage();
                }
              },
            ),
          ],
        ),
        body: Obx(
          () => controllerChat!.chatListQuestions.isEmpty
              ? const SpinKitCircle(
                  color: Color.fromRGBO(187, 229, 169, 1),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controllerChat!.chatListQuestions.length,
                  addAutomaticKeepAlives: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FAQItem(
                          question: controllerChat!.chatListQuestions[index],
                          answer: controllerChat!.chatListAnswer[index],
                        ),
                      ],
                    );
                  }),
        ));
  }
}

