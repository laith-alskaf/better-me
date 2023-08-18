import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/color/AppColors.dart';
import 'package:BetterMe/ui/views/main_view/calculater/shared/Function/myfunc.dart';

class FatEatView extends StatefulWidget {
  const FatEatView({Key? key}) : super(key: key);

  @override
  State<FatEatView> createState() => _FatEatViewState();
}

class _FatEatViewState extends State<FatEatView> {

  String? selectedGender='male'; // تعريف متغير لتخزين الخيار المختار
  String gender='male';
  GlobalKey<FormState> Key= GlobalKey<FormState>();
  TextEditingController agecontralar= TextEditingController();
  TextEditingController tallcontralar= TextEditingController();
  TextEditingController wghitcontrolar=TextEditingController();
  String traningtxt="less traning 1-2 day";
  double bmr=0;
  double calories=0;


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Form(
      key: Key,
      child: Scaffold(
        appBar: AppBar(
          // brightness: Brightness.light,
          backgroundColor: AppColors.lightGreen,
          elevation: 50,
          centerTitle: true,
          shadowColor: Colors.black.withOpacity(.5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                'Fat Need',
                style: TextStyle(
                    color: AppColors.blackwithopacity,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1),
              ),
              IconButton(onPressed: (){
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'يعتمد حساب الدهون المحتاجة يومياً للجسم على الوزن والجنس، بالإضافة إلى النشاط البدني الذي يمارسه الفرد. يتم حساب الدهون المحتاجة بالاعتماد على الاحتياجات اليومية للسعرات الحرارية، التي يحتاجها الجسم لممارسة نشاطاته اليومية.'
               ,titleTextStyle: TextStyle(color: AppColors.lightGreen)  , btnCancelOnPress: () {},
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

            },
          ),

        ),
        body: Padding(
          padding:  EdgeInsets.only(
              left: size.width*0.04,
              right: size.width*0.04,
              bottom: size.width*0.04,
              top: size.width*0.06
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                color: AppColors.greybackground,
                child: Padding(
                  padding:  EdgeInsets.only(left: size.width*0.01),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top:size.width*0.065,
                                right: size.width*0.03),
                            child: SvgPicture.asset("images/cake.svg",
                            ),
                          ),
                          Container(
                            width: size.width*0.819,

                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if(value!.isEmpty)
                                {return 'enter your age';}
                                else if(double.parse(agecontralar.text)>110)
                                {
                                  return 'please enter real age';

                                }

                                else return null;

                              },
                              controller: agecontralar,

                              cursorColor: AppColors.lightGreen,
                              decoration: InputDecoration(
                                  focusedBorder:UnderlineInputBorder(
                                    borderSide:  BorderSide(color: AppColors.lightGreen, width: 1.5),
                                  ),


                                  hintText: 'age',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,

                                  ),
                                  contentPadding: EdgeInsets.all( size.width*0.0)
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top:size.width*0.065,
                                right: size.width*0.03),
                            child: SvgPicture.asset("images/scale-bathroom.svg",
                            ),
                          ),
                          Container(
                            width: size.width*0.5,
                            child: TextFormField(
                              validator: (value){
                                if(value!.isEmpty)
                                {return 'enter your wghite';}
                                else if(double.parse(wghitcontrolar.text)>110)
                                {
                                  return 'please enter real wghit';
                                }
                                else return null;

                              },
                              controller: wghitcontrolar,
                              cursorColor: AppColors.lightGreen,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  focusedBorder:UnderlineInputBorder(
                                    borderSide:  BorderSide(color: AppColors.lightGreen, width: 1.5),
                                  ),

                                  hintText: 'whight',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,

                                  ),
                                  contentPadding: EdgeInsets.all( size.width*0.0)
                              ),
                            ),
                          ),
                          SizedBox(width: size.width*0.02,),

                          Padding(
                            padding:  EdgeInsets.only(top:size.width*0.065),
                            child: Text("Kg",
                              style: TextStyle(color: Colors.black,
                                  fontSize: size.width*0.05),),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top:size.width*0.065,
                                right: size.width*0.03),
                            child: SvgPicture.asset("images/human-male-height-variant.svg",
                            ),
                          ),
                          Container(
                            width: size.width*0.819,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if(value!.isEmpty)
                                {return 'enter your tall';}
                                else if(double.parse(wghitcontrolar.text)>110)
                                {
                                  return 'please enter real tall';

                                }

                                else return null;

                              },
                              controller: tallcontralar,
                              cursorColor: AppColors.lightGreen,
                              decoration: InputDecoration(
                                  focusedBorder:UnderlineInputBorder(
                                    borderSide:  BorderSide(color: AppColors.lightGreen, width: 1.5),
                                  ),

                                  hintText: 'enter your tall with cm',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,

                                  ),
                                  contentPadding: EdgeInsets.all( size.width*0.0)
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.width*0.07,),
                      Row(
                        children: [
                          SvgPicture.asset("images/gender-male.svg"),
                          Radio(

                            value: "male",
                            activeColor: Colors.black,
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                gender='male';
                                selectedGender = value; // تغيير قيمة الـ groupValue عند اختيار الخيار
                              });

                            },
                          ),
                          Text("male"
                              , style: TextStyle(
                                  color: Colors.black
                              )),
                          SizedBox(width: size.width/3,),
                          SvgPicture.asset("images/gender-female.svg"),
                          Radio(
                            value: "female",
                            groupValue: selectedGender,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value; // تغيير قيمة الـ groupValue عند اختيار الخيار
                                gender='fmale';
                              });
                              print(value); //selected value
                            },
                          ),
                          Text("female",
                              style: TextStyle(
                                  color: Colors.black
                              )),

                        ],
                      ),
                      SizedBox(height: size.width*0.07,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("traning level",
                            style: TextStyle(fontSize: size.width*0.04,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: size.width*0.04),
                            child:SvgPicture.asset("images/dumbbell.svg",
                              color: Colors.grey,),)

                        ],),

                      Padding(
                          padding:  EdgeInsets.symmetric(vertical: size.width*0.04),
                          child: InkWell(
                            onTap: (){
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.noHeader,
                                body: Column(
                                  children: [
                                    InkWell(
                                        onTap: (){
                                          setState(() {
                                            traningtxt="less traning 1-2 day";

                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text("less traning 1-2 day")),
                                    SizedBox(height: 10,),
                                    InkWell(onTap:(){
                                      setState(() {
                                        traningtxt="normal traning 1-3 day";


                                      });
                                      Navigator.pop(context);
                                    },
                                        child: Text("normal traning 1-3 day")),
                                    SizedBox(height: 10,),

                                    InkWell(onTap:(){
                                      setState(() {
                                        traningtxt="hard traning 3-5 day";                                });
                                      Navigator.pop(context);
                                    },
                                        child: Text("hard traning 3-5 day")),
                                    SizedBox(height: 10,),
                                    InkWell(onTap:(){
                                      setState(() {
                                        traningtxt="extra traning 6-7 day";
                                      });
                                      Navigator.pop(context);


                                    },
                                        child: Text("extra traning 6-7 day")),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                                btnCancelOnPress: () {

                                },
                              )..show();
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text(traningtxt),
                                IconButton(onPressed: (){


                                }, icon: Icon(Icons.chevron_right_outlined))
                              ],
                            ),
                          )
                      ),


                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
                            child: ElevatedButton(onPressed: (){
                              if(Key.currentState!.validate())
                              {
                                bmr=calcbmr1(
                                    double.parse(tallcontralar.text),
                                    double.parse(agecontralar.text),
                                    double.parse(wghitcontrolar.text),
                                    gender
                                );
                                calories=calloresneed(bmr,traningtxt)/9;

                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'كمية الدهون المحتاجة يوميا هي',
                                  desc:calories.toStringAsFixed(0),descTextStyle: TextStyle(color: AppColors.lightGreen),
                                  btnOkOnPress: () {},
                                )..show();
                              }},
                                child: Row(
                                  children: [
                                    SvgPicture.asset("images/calculator.svg",
                                      color: AppColors.blackwithopacity,
                                      width: size.width*0.1,
                                      height:size.width*0.088 ,
                                    ),
                                    SizedBox(width: size.width*0.02,),
                                    Text("Calculate",
                                        style: TextStyle(color:AppColors.blackwithopacity,
                                            fontSize: size.width*0.04)),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.lightGreen,
                                    fixedSize: Size(size.width*0.38, size.width*0.1)
                                )

                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
                            child: ElevatedButton(onPressed: (){
                              setState(() {
                                wghitcontrolar.text='';
                                agecontralar.text='';
                                tallcontralar.text='';
                                selectedGender="male";
                                traningtxt="less traning 1-2 day";
                              });

                            },
                                child: Row(
                                  children: [
                                    SvgPicture.asset("images/restore.svg",
                                      color: AppColors.blackwithopacity,
                                      width: size.width*0.1,
                                      height:size.width*0.088 ,
                                    ),
                                    SizedBox(width: size.width*0.02,),
                                    Text("Reset",
                                        style: TextStyle(color:AppColors.blackwithopacity,
                                            fontSize: size.width*0.04)),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.lightGreen,
                                    fixedSize: Size(size.width*0.38, size.width*0.1)
                                )

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,)


                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

}
