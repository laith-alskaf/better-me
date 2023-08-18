import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:BetterMe/ui/views/main_view/calculater/View/shared/Custum_View.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/Function/myfunc.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/color/AppColors.dart';

class WaterInBodyView extends StatefulWidget {
  const WaterInBodyView({Key? key}) : super(key: key);

  @override
  State<WaterInBodyView> createState() => _WaterInBodyViewState();
}

class _WaterInBodyViewState extends State<WaterInBodyView> {
  TextEditingController agecontrolar=TextEditingController();
  TextEditingController tallcontrolar=TextEditingController();
  TextEditingController wghitecontrolar=TextEditingController();
  String selectgender='male';
  double waterinbody=0;
  @override
  Widget build(BuildContext context) {
    return CustumView(color: AppColors.blue, age: true, titel: 'الماء بجسمك',
        agecontrolar: agecontrolar,
    wghiteontrolar: wghitecontrolar,
    tallcontrolar: tallcontrolar,
    selectedGender: selectgender,
    tallvalidator:(value){
      if(value!.isEmpty)
      {return 'enter your tall';}
      else if(double.parse(tallcontrolar.text)>250)
      {
        return 'please enter real wghit';

      }

      else return null;

    },
    agevalidator:(value){
      if(value!.isEmpty)
      {return 'enter your age';}
      else if(double.parse(agecontrolar.text)>110)
      {
        return 'please enter real age';

      }

      else return null;

    },
    wghotevalidator:(value){
      if(value!.isEmpty)
      {return 'enter your wghit';}
      else if(double.parse(wghitecontrolar.text)>170)
      {
        return 'please enter real wghit';

      }

      else return null;

    } ,
    infoonpresed: (){
      AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: '  يستخدم هذا النموذج الوزن والطول والعمر والجنس لتقدير نسبة الماء في الماء حسب نموذج سوتناغ '
          ,titleTextStyle: TextStyle(color: AppColors.blue)

      )..show();
    },
      onchange: (value){ setState(() {
        selectgender = value; // تغيير قيمة الـ groupValue عند اختيار الخيار
      });},
    onpresed:(){
      waterinbody=WaterInBody(double.parse(agecontrolar.text), double.parse(wghitecontrolar.text),
          double.parse(tallcontrolar.text), selectgender);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.noHeader,
          animType: AnimType.rightSlide,
          title: 'نسبة الماء الكلية بجسمك هو',
          titleTextStyle: TextStyle(color: AppColors.blue),
        desc: waterinbody.toStringAsFixed(0)+'\n'+' لتر',descTextStyle: TextStyle(color: AppColors.blue),

      )..show();



    },);
  }
}
