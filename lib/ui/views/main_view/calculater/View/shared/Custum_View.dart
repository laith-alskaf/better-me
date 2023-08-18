import 'package:BetterMe/ui/views/main_view/calculater/shared/color/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class CustumView extends StatefulWidget {
  const CustumView({Key? key, required this.color, required this.age, required this.titel, this.whight, this.tall, this.agecontrolar, this.tallcontrolar, this.wghiteontrolar, this.infoonpresed, this.agevalidator, this.tallvalidator, this.wghotevalidator, this.onpresed, this.selectedGender, this.onchange}) : super(key: key);
  final Color color;
  final bool? age;
  final bool  ?whight;
  final bool? tall;
  final String titel;
  final TextEditingController? agecontrolar;
  final TextEditingController? tallcontrolar;
  final TextEditingController? wghiteontrolar;
  final Function? infoonpresed;
  final Function? onchange;
  final String? Function(String?)? agevalidator;
  final String? Function(String?)? tallvalidator;
  final String? Function(String?)? wghotevalidator;
  final Function? onpresed;
  final String? selectedGender; // تعريف متغير لتخزين الخيار المختار





  @override
  State<CustumView> createState() => _CustumViewState();
}
GlobalKey<FormState> key= GlobalKey<FormState>();

class _CustumViewState extends State<CustumView> {
  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.light,
        backgroundColor: widget.color,
        elevation: 50,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.titel,
              style: TextStyle(
                  color: AppColors.blackwithopacity,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
            IconButton(onPressed: (){
              widget.infoonpresed!();
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
        key: key,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding:  EdgeInsets.only(
                  left: size.width*0.04,
                  right: size.width*0.04,
                  bottom: size.width*0.04,
                  top: size.width*0.06
              ),
              child: Container(
                color: AppColors.greybackground,
                child: Column(
                  children: [
               widget.age??true
                   ?Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top:size.width*0.065,
                              right: size.width*0.03),
                          child: SvgPicture.asset("images/cake.svg",
                          ),
                        ),
                        Container(
                          width: size.width*0.81999,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: widget.agecontrolar,
                            validator: widget.agevalidator,
                            cursorColor: widget.color,
                            decoration: InputDecoration(

                                focusedBorder:UnderlineInputBorder(
                                  borderSide:  BorderSide(color: widget.color, width: 1.5),
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
                    ):SizedBox(),
               widget.whight??true   ?  Row(
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
                            validator: widget.wghotevalidator,
                            keyboardType: TextInputType.number,
                            controller: widget.wghiteontrolar,
                            cursorColor: widget.color,
                            decoration: InputDecoration(
                                focusedBorder:UnderlineInputBorder(
                                  borderSide:  BorderSide(color: widget.color, width: 1.5),
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
                    ):SizedBox(),
                    widget.tall??true?Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top:size.width*0.065,
                              right: size.width*0.03),
                          child: SvgPicture.asset("images/human-male-height-variant.svg",
                          ),
                        ),
                        Container(
                          width: size.width*0.81999,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller:widget.tallcontrolar ,
                            validator: widget.tallvalidator,
                            cursorColor: widget.color,
                            decoration: InputDecoration(
                                focusedBorder:UnderlineInputBorder(
                                  borderSide:  BorderSide(color: widget.color, width: 1.5),
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
                    ):SizedBox(),
                    SizedBox(height: size.width*0.07,),
                    Row(
                      children: [
                        SvgPicture.asset("images/gender-male.svg"),
                        Radio(

                          value: "male",
                          activeColor: Colors.black,
                          groupValue: widget.selectedGender??'male',
                          onChanged: (value) {
                            widget.onchange!(value);
                            print(value);

                          },
                        ),
                        Text("male",
                            style: TextStyle(
                                color: Colors.black
                            )
                        ),
                        SizedBox(width: size.width*0.35,),
                        SvgPicture.asset("images/gender-female.svg"),
                        Radio(
                          value: "female",
                          groupValue: widget.selectedGender,
                          activeColor: Colors.black,
                          onChanged: (value) {

                            widget.onchange!(value);
                            print(value); //selected value
                          },
                        ),
                        Text("female",
                            style: TextStyle(
                                color: Colors.black
                            )
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.width*0.04),
              child: ElevatedButton(onPressed: (){
                if(key.currentState!.validate())

                    {
                  widget.onpresed!();
                     }
              },
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
                      backgroundColor:widget. color,
                      fixedSize: Size(double.infinity, size.width*0.1)
                  )

              ),
            )
          ],
        ),
      ),

    );
  }

}
