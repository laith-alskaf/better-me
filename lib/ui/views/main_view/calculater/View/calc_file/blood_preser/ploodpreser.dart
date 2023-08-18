
import 'package:BetterMe/ui/views/main_view/calculater/shared/Function/myfunc.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/color/AppColors.dart';
import 'package:flutter/material.dart';
import '../../shared/Custum_View.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PloodPreser extends StatefulWidget {
  const PloodPreser({Key? key}) : super(key: key);

  @override
  State<PloodPreser> createState() => _PloodPreserState();
}

class _PloodPreserState extends State<PloodPreser> {
  TextEditingController tallcon=TextEditingController();
  TextEditingController wghitecon=TextEditingController();
  String? selectedGender='male';
  double totelblod=0;

  @override
  Widget build(BuildContext context) {
    return CustumView(color: AppColors.lightGreen,
        age: false,
        titel: "نسبة حجم الدم الكلية بالجسم",
      selectedGender: selectedGender,
      tallcontrolar: tallcon,
      onchange: (value){ setState(() {
        selectedGender = value; // تغيير قيمة الـ groupValue عند اختيار الخيار
      });},
      onpresed: (){
      totelblod=BloodinBody(
        double.parse(wghitecon.text),
        double.parse(tallcon.text),
        selectedGender!,
      );
        AwesomeDialog(
            context: context,
            dialogType: DialogType.noHeader,
            animType: AnimType.rightSlide,
            title: 'نسبة حجم الدم الكلية بالجسم هي',
          titleTextStyle: TextStyle(color:AppColors.lightGreen),
            desc: totelblod.toString(),
        )..show();

      },
      infoonpresed:(){
        AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'يتم حساب حجم الدم الكلي بالنسبة للأشخاص على أساس الجنس والوزن والطول، ولكن هذا التقدير يعتمد على النموذج الذي يتم استخدامه للحساب.'
            ,titleTextStyle:  TextStyle(color:AppColors.lightGreen)
        )..show();
      } ,
      tallvalidator: (value){
        if(value!.isEmpty)
        {return 'enter your tall';}
        else if(double.parse(tallcon.text)>250)
        {
          return 'please enter real wghit';

        }

        else return null;

      } ,
      wghotevalidator: (value){
        if(value!.isEmpty)
        {return 'enter your wghit';}
        else if(double.parse(wghitecon.text)>170)
        {
          return 'please enter real wghit';

        }

        else return null;

      } ,
      wghiteontrolar:wghitecon ,

    );
  }
}
