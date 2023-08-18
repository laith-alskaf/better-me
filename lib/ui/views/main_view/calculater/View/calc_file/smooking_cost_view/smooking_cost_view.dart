import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/Custum_wedget/Custum_Buttom.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/color/AppColors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SmookingCostView extends StatelessWidget {
  SmookingCostView({Key? key}) : super(key: key);
  GlobalKey<FormState> keyy = GlobalKey<FormState>();
  TextEditingController segaetperdaycontrolar = TextEditingController();
  TextEditingController nameofpacketcontrolar = TextEditingController();
  TextEditingController costofpacketcontrolar = TextEditingController();
  double monthlycost = 0;
  double yearcost = 0;
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        // brightness: Brightness.light,
        backgroundColor: AppColors.smook,
        elevation: 50,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Smooking Cost',
              style: TextStyle(
                  color: AppColors.blackwithopacity,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
            IconButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'تكلفة التدخين',
                    titleTextStyle: TextStyle(color: AppColors.smook),
                    desc: 'السجائر المدخنة يوميا مجموع السجائر في '
                        'دخان التبغ. التدخين يزيد من خطر ال:صابة بسرطان '
                        'الرئة بحوالي 15 إلى 30 مرة، ويزيد أيضا من خطر'
                        ' اصابة بالنوبات القلبية. إذا كنت الدقادع عن التدخين'
                        '  للحد من خطر الوفاة المبكرة بنسبة لسن ال 30'
                        "  تقارب 90 في المئة. إذا كنت عن التدخين في"
                        "سن 50 يقلل من خطر الوفاة المبكرة بنسبة 50 في"
                        "المائة. الحد أكثر أمانا من التعرض لدخان التبغ غير"
                        "متوفر. على متوسط المدخنين يموتون في وقت سابق"
                        "  من 14 عاما. دخان التبغ يسبب حوالي   6000 حالة وفاة سنويا",
                    descTextStyle: TextStyle(color: AppColors.smook),
                  )..show();
                },
                icon: Icon(
                  Icons.info,
                  color: AppColors.blackwithopacity,
                ))
          ],
        ),

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black.withOpacity(.5),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: size.width * 0.04,
            right: size.width * 0.04,
            bottom: size.width * 0.04,
            top: size.width * 0.06),
        child: Form(
          key: keyy,
          child: Column(
            children: [
              Container(
                color: AppColors.greybackground,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.01),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.width * 0.065,
                                right: size.width * 0.03),
                            child: SvgPicture.asset(
                              "images/smoking.svg",
                            ),
                          ),
                          Container(
                            width: size.width * 0.8,
                            child: TextFormField(
                              controller: segaetperdaycontrolar,
                              cursorColor: AppColors.smook,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return'not should be empty';
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.smook, width: 1.5),
                                  ),
                                  hintText: 'number of segarettes per day',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  contentPadding:
                                      EdgeInsets.all(size.width * 0.0)),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.width * 0.065,
                                right: size.width * 0.03),
                            child: SvgPicture.asset(
                              "images/plus-circle.svg",
                            ),
                          ),
                          Container(
                            width: size.width * 0.8,
                            child: TextFormField(
                              controller: nameofpacketcontrolar,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return'not should be empty';
                                }
                              },
                              cursorColor: AppColors.smook,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.smook, width: 1.5),
                                  ),
                                  hintText: 'the number of segarettes in pack',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  contentPadding:
                                      EdgeInsets.all(size.width * 0.0)),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.width * 0.065,
                                right: size.width * 0.03),
                            child: SvgPicture.asset(
                              "images/currency-usd.svg",
                            ),
                          ),
                          Container(
                            width: size.width * 0.8,
                            child: TextFormField(
                              controller: costofpacketcontrolar,
                              cursorColor: AppColors.smook,
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if (value!.isEmpty) {
                                  return 'not should be empty';
                                }
                              },
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.smook, width: 1.5),
                                  ),
                                  hintText: 'the cost of pack',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  contentPadding:
                                      EdgeInsets.all(size.width * 0.0)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              CustomButtom(
                  onpresed: () {
                    if (keyy.currentState!.validate()) {
                      double pack = 0;
                      pack = double.parse(segaetperdaycontrolar.text) /
                          double.parse(nameofpacketcontrolar.text);
                      double cost =
                          pack * double.parse(costofpacketcontrolar.text);
                      monthlycost = cost * 30;
                      //     SmookCost(
                      //   double.parse(segaetperdaycontrolar.text),
                      //   double.parse(nameofpacketcontrolar.text),
                      //   double.parse(costofpacketcontrolar.text),
                      // );
                      yearcost = monthlycost * 12;
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.noHeader,
                        animType: AnimType.rightSlide,
                        title: 'التكلفة الشهرية هي $monthlycost\n'
                            'التكلفة السنوية هي $yearcost',
                        titleTextStyle: TextStyle(color: AppColors.smook),
                      )..show();
                    }
                  },
                  color: AppColors.smook)
            ],
          ),
        ),
      ),
    ));
  }
}
