import 'package:BetterMe/ui/views/main_view/calculater/View/calc_file/perfect_wight_view/perfect_whight_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:BetterMe/ui/views/main_view/calculater/View/calc_file/blood_preser/ploodpreser.dart';
import 'package:BetterMe/ui/views/main_view/calculater/View/calc_file/fat_eat_view/fat_eat_view.dart';
import 'package:BetterMe/ui/views/main_view/calculater/View/calc_file/water_in_body_view/water_in_body_view.dart';
import 'dart:ui';

import '../calc_file/bloodpreser/blood_preser_view.dart';
import '../calc_file/bmi/bmi.dart';
import '../calc_file/calories/calories_view.dart';
import '../calc_file/smooking_cost_view/smooking_cost_view.dart';

class CalcPage extends StatefulWidget {
  @override
  _CalcPageState createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ListView
          ListView(
            physics:AlwaysScrollableScrollPhysics(),
           // BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(_w / 17, _w / 20, 0, _w / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: _w / 35),
                    NeumorphicText(
                      'Calculat things improve your health',
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
                    // Text(
                    //   'Calculat things improve your health',
                    //   style: TextStyle(
                    //     fontSize: 19,
                    //     color: Colors.black.withOpacity(.5),
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    //   textAlign: TextAlign.start,
                    // ),
                  ],
                ),
              ),
              homePageCardsGroup(
                Color(0xfff37736),
                'images/scale-bathroom.svg',
                'BMI',
                context,
                BMI(),
                Color(0xffFF6D6D),
                'images/calculator.svg',
                'حاسب السعرات الحرارية',
                CaloriesView(),
              ),
              homePageCardsGroup(
                  Colors.lightGreen,
                 "images/heart-pulse.svg",
                  'نسبة الدم في الجسم',
                  context,
                  PloodPreser(),
                  Color(0xffffa700),
                  "images/blood-bag.svg",
                  'نسبة ضغط الدم',
                  BloodPressure()),
              homePageCardsGroup(
                  // Color(0xff63ace5),
                  Color(0xffFF6D6D),
                  "images/smoking-off.svg",
                  'تكلفة التدخين',
                  context,
                  SmookingCostView(),
                  Color(0xfff37736),
                  "images/alarm-panel.svg",
                  'الوزن المثالي',
                  PerfectWightView()),
              homePageCardsGroup(
                  Color(0xff63ace5),
                  'images/water.svg',
                  'الماء في جسمك',
                  context,
                  WaterInBodyView(),
                  Colors.lightGreen,
                  'images/food.svg',
                  'اكل الدهون',
                  FatEatView()),

              SizedBox(height: _w / 20),
            ],
          ),


          // Blur the Status bar
          blurTheStatusBar(context),
        ],
      ),
    );
  }

  Widget homePageCardsGroup(
      Color color,
      String img,
      String title,
      BuildContext context,
      Widget route,
      Color color2,
      String img1,
      String title2,
      Widget route2) {
    double _w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: _w / 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          homePageCard(color, img, title, context, route),
          homePageCard(color2, img1, title2, context, route2),
        ],
      ),
    );
  }

  Widget homePageCard(Color color, String img, String title,
      BuildContext context, Widget route,
      ) {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(

        offset: Offset(0, _animation2.value),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return route;
                },
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(15),
            height: _w / 2,
            width: _w / 2.4,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff040039).withOpacity(.15),
                  blurRadius: 99,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(img,
                color:color.withOpacity(.6) ,
                width: _w*0.13,
                height: _w*0.13,),
                Text(
                  title,
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget blurTheStatusBar(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Container(
          height: _w / 18,
          color: Colors.transparent,
        ),
      ),
    );
  }
}







