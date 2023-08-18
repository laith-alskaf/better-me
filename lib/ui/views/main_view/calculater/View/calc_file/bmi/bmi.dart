import 'package:BetterMe/ui/views/main_view/calculater/shared/color/AppColors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/Function/myfunc.dart';

class BMI extends StatefulWidget {
  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  TextEditingController wghitcontrolar = TextEditingController();
  TextEditingController tallcontrolar = TextEditingController();
  TextEditingController agecontrolar = TextEditingController();
  double bmi = 0;
  Color colorOfBmiCheck = Colors.brown;
  String Txt = "";
  String? selectedGender = 'male'; // تعريف متغير لتخزين الخيار المختار
  GlobalKey<FormState> Key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<dynamic> bmilist = [Txt, colorOfBmiCheck];

    var size = MediaQuery.of(context).size;
    return Form(
      key: Key,
      child: Scaffold(
        appBar: AppBar(
          // brightness: Brightness.light,
          backgroundColor: AppColors.bmicolor,
          elevation: 50,
          centerTitle: true,
          shadowColor: Colors.black.withOpacity(.5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bmi',
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
                      animType: AnimType.bottomSlide,
                      title: " مؤشر كتلة الجسم يرمز إلى مؤشر كتلة الجسم ، وهو "
                          ' مقياس الدهون في الجسم بناءً على'
                          ' وزن الأشخاص وطولهم هو'
                          'حسابية بسيطة توفر  تقدير لمقدار الدهون في الجسم',
                      titleTextStyle: TextStyle(color: AppColors.bmicolor),
                      desc: 'تحت الوزن: BMI less than 18.5\n'
                          'طبيعي: BMI between 18.5 and 24.9\n'
                          'وزن زائد: BMI between 25 and 29.9\n'
                          'زيادة كبيرة: BMI 30 or higher',
                      descTextStyle: TextStyle(color: AppColors.bmicolor),
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                  bottom: size.width * 0.04,
                  top: size.width * 0.06),
              child: Container(
                color: AppColors.greybackground,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.width * 0.065,
                              right: size.width * 0.03),
                          child: SvgPicture.asset(
                            "images/cake.svg",
                          ),
                        ),
                        Container(
                          width: size.width * 0.81999,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter your age';
                              } else if (double.parse(agecontrolar.text) >
                                  110) {
                                return 'please enter real age';
                              } else
                                return null;
                            },
                            controller: agecontrolar,
                            cursorColor: AppColors.bmicolor,
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.bmicolor, width: 1.5),
                                ),
                                hintText: 'age',
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
                            "images/scale-bathroom.svg",
                          ),
                        ),
                        Container(
                          width: size.width * 0.5,
                          child: TextFormField(
                            maxLength: 3,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter your wghit';
                              } else if (double.parse(wghitcontrolar.text) >
                                  170) {
                                return 'please enter real wghit';
                              } else
                                return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: wghitcontrolar,
                            cursorColor: AppColors.bmicolor,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.bmicolor, width: 1.5),
                                ),
                                hintText: 'whight',
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
                        Padding(
                          padding: EdgeInsets.only(top: size.width * 0.065),
                          child: Text(
                            "Kg",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.05),
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
                            "images/human-male-height-variant.svg",
                          ),
                        ),
                        Container(
                          width: size.width * 0.81999,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter your tall';
                              } else if (double.parse(tallcontrolar.text) >
                                  250) {
                                return 'please enter real wghit';
                              } else
                                return null;
                            },
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            controller: tallcontrolar,
                            cursorColor: AppColors.bmicolor,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.bmicolor, width: 1.5),
                                ),
                                hintText: 'enter your tall with cm',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                contentPadding:
                                    EdgeInsets.all(size.width * 0.0)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.07,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("images/gender-male.svg"),
                        Radio(
                          value: "male",
                          activeColor: Colors.black,
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender =
                                  value; // تغيير قيمة الـ groupValue عند اختيار الخيار
                            });
                          },
                        ),
                        Text("male", style: TextStyle(color: Colors.black)),
                        SizedBox(
                          width: size.width * 0.35,
                        ),
                        SvgPicture.asset("images/gender-female.svg"),
                        Radio(
                          value: "female",
                          groupValue: selectedGender,
                          activeColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              selectedGender =
                                  value; // تغيير قيمة الـ groupValue عند اختيار الخيار
                            });
                            print(value); //selected value
                          },
                        ),
                        Text("female", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: ElevatedButton(
                  onPressed: () {
                    if (Key.currentState!.validate()) {
                      setState(() {
                        bmi = double.parse(wghitcontrolar.text) /
                            (((double.parse(tallcontrolar.text) *
                                    double.parse(tallcontrolar.text))) *
                                0.0001);
                        bmilist = checkBMIstate(bmi);
                      });

                      AwesomeDialog(
                          closeIcon: Container(
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            decoration: BoxDecoration(
                              color: bmilist[1],
                              // تغيير لون خلفية الأيقونة باللون الأحمر
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          showCloseIcon: true,
                          context: context,
                          dialogType: DialogType.noHeader,
                          animType: AnimType.BOTTOMSLIDE,
                          btnOkColor: bmilist[1],
                          title: bmilist[0],
                          desc: bmi.toStringAsFixed(2),
                          descTextStyle: TextStyle(fontSize: size.width * 0.04),
                          btnOkOnPress: () {})
                        ..show();
                    }
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "images/calculator.svg",
                        color: AppColors.blackwithopacity,
                        width: size.width * 0.1,
                        height: size.width * 0.088,
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text("Calculate",
                          style: TextStyle(
                              color: AppColors.blackwithopacity,
                              fontSize: size.width * 0.04)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bmicolor,
                      fixedSize: Size(double.infinity, size.width * 0.1))),
            )
          ],
        ),
      ),
    );
  }
}
