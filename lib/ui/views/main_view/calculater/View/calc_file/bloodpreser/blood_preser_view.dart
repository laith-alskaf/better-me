
import 'package:BetterMe/ui/views/main_view/calculater/shared/Custum_wedget/Custum_Buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/Function/myfunc.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/color/AppColors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class BloodPressure extends StatefulWidget {
  const BloodPressure({Key? key}) : super(key: key);

  @override
  State<BloodPressure> createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {
  TextEditingController upcontrolar=TextEditingController();
  TextEditingController dwoncontrolar=TextEditingController();
  GlobalKey<FormState> Key= GlobalKey<FormState>();
  String state='';
  double calc=0;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
        appBar: AppBar(
      // brightness: Brightness.light,
      backgroundColor: AppColors.lighred,
      elevation: 50,
      centerTitle: true,
      shadowColor: Colors.black.withOpacity(.5),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ضغط الدم',
            style: TextStyle(
                color: AppColors.blackwithopacity,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          IconButton(onPressed: (){
            AwesomeDialog(
                context: context,
                dialogType: DialogType.info,
                desc: 'يسمى ضغط الدم المنتشرة داخل الشرايين ضغط الدم\n'
                    'وسوف تزيد خادل ضربات القلب ويقلل عندما يكون'
                      'لقاضي والضغط اخبساطي.ويسمى الضغط الذي'
                    'يحدث أثناء ضخ الدم ضغط الدم نقباضي ويقاس'
                'في ملليمتر من الزئبق وحدة. مجموعة إنقباض العادي'
                'الضغط الذي mercury.the 90 - 120 ملم من'
                'يحدث أثناء يسمى يستريح القلب وقياس ضغط الدم'
                'الدم في ملليمتر من الزنبق pressureit نبساطي'
                'وحدة. مجموعة أنبساط العادي هو 60 - 80 مليمتر من الزئبق',
              descTextStyle: TextStyle(color: AppColors.lighred),
            )..show();
          }, icon: Icon(Icons.info,
            color: AppColors.blackwithopacity,))
        ],
      ),

      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black.withOpacity(.5),
        ),
        onPressed: () {
          Navigator.pop(context);
          // Navigator.push(context,MaterialPageRoute(builder: (context) {
          //   return CalcPage();
          // },));
        },
      ),

    ),
      body: Form(
        key: Key,
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical: size.width*0.04,
              horizontal: size.width*0.04),
              child: Column(
                children: [
                  Container(
                    width:size.width ,
                    color: AppColors.greybackground,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: size.width*0.06,right: size.width*0.01),
                              child: SvgPicture.asset("images/chevron-up-circle-outline.svg",
                              width: size.width*0.1,
                              height: size.width*0.1 ,),
                            ),
                            Container(width: size.width*0.80,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: AppColors.lighred,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      'not should be empty';
                                    }
                                  },
                                  controller: upcontrolar,
                                  decoration: InputDecoration(
                                      focusedBorder:UnderlineInputBorder(
                                        borderSide:  BorderSide(color: AppColors.lighred, width: 1.5),
                                      ),
                                      hintText: 'Systolic blood pressure',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      contentPadding: EdgeInsets.all( size.width*0.0)
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: size.width*0.06,right: size.width*0.01),
                              child: SvgPicture.asset("images/chevron-down-circle-outline.svg",
                                  width: size.width*0.1,
                                  height: size.width*0.1),
                            ),
                            Container(width: size.width*0.80,
                                child: TextFormField(
                                  cursorColor: AppColors.lighred,
                                  controller: dwoncontrolar,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      'not should be empty';
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      focusedBorder:UnderlineInputBorder(
                                        borderSide:  BorderSide(color: AppColors.lighred, width: 1.5),
                                      ),

                                      hintText: 'diastolic blood pressure',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(height: size.width*0.05,)
                      ],
                    ),

                  ),
                  SizedBox(height: size.width*0.04,),
                  CustomButtom(onpresed: (){
                    if(Key.currentState!.validate())
                    {
                      state=BllodState(
                          calc,
                          double.parse(upcontrolar.text),
                          double.parse(dwoncontrolar.text)
                      );
                      AwesomeDialog(
                        dialogType: DialogType.noHeader,
                        context: context,
                        title: state,titleTextStyle:  TextStyle(color: Colors.red),
                      )..show();
                    }

                  }, color: AppColors.lighred)
                ],
              ),

            ),

          ],

        ),
      ),

    ));
  }
}
