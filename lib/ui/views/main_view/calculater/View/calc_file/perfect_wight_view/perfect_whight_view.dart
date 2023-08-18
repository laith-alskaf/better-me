import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:BetterMe/ui/views/main_view/calculater/View/shared/Custum_View.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/color/AppColors.dart';

class PerfectWightView extends StatefulWidget {
  const PerfectWightView({Key? key}) : super(key: key);

  @override
  State<PerfectWightView> createState() => _PerfectWightViewState();
}

class _PerfectWightViewState extends State<PerfectWightView> {
  String selectgender = 'male';
  double wghite = 0;
  TextEditingController tallcontrolar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustumView(
      selectedGender:selectgender ,
      color: AppColors.perfectweght,
      age: false,
      titel: "perfect wight",
      whight: false,
      infoonpresed: () {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'الوزن المثالي',
            titleTextStyle: TextStyle(color: AppColors.perfectweght),
            desc: 'يستخدم المثالي حساب وزن الجسم للتحقق من الوزن'
                'مناسب لادرتفاع لمنع المخاطر الصحية كما أنها تستخدم'
                'في الطب لمجموعة متنوعة من اذغراض، بما في ذلك'
                'جرعات المخدرات، وضبط التهوية الميكانيكية',
            descTextStyle: TextStyle(color: AppColors.perfectweght))
          ..show();
      },
      tallcontrolar: tallcontrolar,
      tallvalidator: (value) {
        if (value!.isEmpty) {
          return 'enter your tall';
        } else if (double.parse(tallcontrolar.text) > 250) {
          return 'please enter real tall';
        } else
          return null;
      },
      onchange: (value) {
        setState(() {
          selectgender = value; // تغيير قيمة الـ groupValue عند اختيار الخيار
        });
      },
      onpresed: () {
        double tall = double.parse(tallcontrolar.text);
        wghite = 24 * (tall * tall * 0.0001);
        AwesomeDialog(
            context: context,
            dialogType: DialogType.noHeader,
            animType: AnimType.rightSlide,
            title: 'الوزن المثالي هو',
            desc: wghite.toString() + '  KG',
            descTextStyle: TextStyle(color: AppColors.perfectweght),
            btnOkOnPress: () {},
            btnOkColor: AppColors.perfectweght)
          ..show();
      },
    );
  }
}
