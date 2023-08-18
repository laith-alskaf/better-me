import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:BetterMe/ui/shared/custom_widget/Custom_Text.dart';
import 'package:BetterMe/ui/shared/text_healthy.dart';
import 'package:BetterMe/ui/views/main_view/home_view/shared_grideview_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _currentIndex = 0;
  List<String> trt = [];

   List<int> randomImageIndex=[];
  List<int> generateUniqueRandomNumber() {
    var random = Random();
    while (randomImageIndex.length < 3) {
      var randomNumber = random.nextInt(17);
      if (!randomImageIndex.contains(randomNumber)) {
        randomImageIndex.add(randomNumber);
      }
    }
    return randomImageIndex;
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  bool isFlipCard = false;
  int isListFlipBackCard = 0;

  @override
  Widget build(BuildContext context) {
    // left: 30, right:30, top: 20

    return  ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, bottom: 10, top: 0),
          child:
          NeumorphicText(
            'The news of healthy',
            textAlign: TextAlign.start,
            style: NeumorphicStyle(
              depth: 4, //customize depth here
              color: Colors.black54, //customize color here
            ),
            textStyle: NeumorphicTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: -10,
              intensity:5,
              boxShape: NeumorphicBoxShape.beveled(BorderRadius.circular(10))
            ),
            padding: EdgeInsets.symmetric(horizontal:5, vertical: 10),
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  addAutomaticKeepAlives: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/pic${generateUniqueRandomNumber()[index]}.jpg"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                      ]),
                    );
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: _items.map((item) => item).toList(),
              // ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[0][0],
          listOfText: CustomText(
            colorText:  Colors.black54,
            fontSizeText: 20,
             
            text: TextHealthy.textHealthy[0][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[1][0],
          listOfText: CustomText(
            colorText:  Colors.black54,
            fontSizeText: 20,
            text: TextHealthy.textHealthy[1][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[2][0],
          listOfText: CustomText(
            colorText: Colors.black54,
            fontSizeText: 20,
            text: TextHealthy.textHealthy[2][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[3][0],
          listOfText: CustomText(
            colorText: Colors.black54,
            fontSizeText: 20,
            text: TextHealthy.textHealthy[3][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[4][0],
          listOfText: CustomText(
            colorText: Colors.black54,
            fontSizeText: 20,
            text: TextHealthy.textHealthy[4][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[5][0],
          listOfText: CustomText(
            colorText: Colors.black54,
            fontSizeText: 20,
            // text: ['kdnasdksadsa', 'sjandsadsada']
            text: TextHealthy.textHealthy[5][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[6][0],
          listOfText: CustomText(
            colorText: Colors.black,
            fontSizeText: 20,
            // text: ['kdnasdksadsa', 'sjandsadsada']
            text:TextHealthy.textHealthy[6][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[7][0],
          listOfText: CustomText(
            colorText:Colors.black54,
            fontSizeText: 20,
            text:TextHealthy.textHealthy[7][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[8][0],
          listOfText: CustomText(
            colorText: Colors.black54,
            fontSizeText:  20,
             
            // text: ['kdnasdksadsa', 'sjandsadsada']
            text: TextHealthy.textHealthy[8][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[9][0],
          listOfText: CustomText(
            colorText: Colors.black54,
            fontSizeText:  20,
             
            // text: ['kdnasdksadsa', 'sjandsadsada']
            text:TextHealthy.textHealthy[9][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[10][0],
          listOfText: CustomText(
            colorText: Colors.black54,
            fontSizeText:  20,
             
            // text: ['kdnasdksadsa', 'sjandsadsada']
            text: TextHealthy.textHealthy[10][1],
          ),
        ),
        SharedGridviewView(
          text: TextHealthy.textHealthy[11][0],
          listOfText: CustomText(
            colorText: Colors.black54,
            fontSizeText:  20,
             
            // text: ['kdnasdksadsa', 'sjandsadsada']
            text: TextHealthy.textHealthy[11][1],
          ),
        ),
        // SharedGridviewView(
        //   text: TextHealthy.textHealthy[0][0],
        //   listOfText: CustomText(
        //     colorText: const [
        //       Colors.amber,
        //       Colors.black54,
        //       Colors.deepOrange,
        //       Colors.amber,
        //       Colors.black54,
        //       Colors.deepOrange,
        //       Colors.amber,
        //       Colors.black54,
        //       Colors.deepOrange,
        //       Colors.black54,
        //       Colors.deepOrange,
        //     ],
        //     fontSizeText: const [20, 18, 18, 18, 20, 23, 14, 19, 23, 25, 13],
        //     lengthText: 11,
        //     // text: ['kdnasdksadsa', 'sjandsadsada']
        //     text: [
        //       for (int i = 0; i < TextHealthy.textHealthy[0].length; i++)
        //         TextHealthy.textHealthy[0][i]
        //     ],
        //   ),
        // ),
      ],
    );

  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentIndex < randomImageIndex.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollController.animateTo(
        _currentIndex * 300.0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutCirc,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
