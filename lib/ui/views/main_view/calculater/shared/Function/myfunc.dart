import 'package:flutter/material.dart';

import '../color/AppColors.dart';

List<dynamic> checkBMIstate(double bmi) {
  String myString = "Hello, world!";
  Color myColor = Colors.blue;
  List<dynamic> check=[myString,myColor];
  if(bmi<18.5){check[0]='تحت الوزن';
  check[1]=AppColors.blue;
  }
  else if (bmi>=18.5&&bmi<25){

    check[0]='وزن طبيعي';
    check[1]=AppColors.lightGreen;

  }

  else if (bmi>=25&&bmi<30){
    check[0]='وزن زائد';
    check[1]=AppColors.lightorang;

  }
  else if (bmi>=30&&bmi<40){
    check[0]='زيادة كبيرة';
    check[1]=Colors.red.withOpacity(0.8);
  }
  else {check[0]="زيادة كبيرة جدا ";
  check[1]=Colors.red;
  }
  return check;
}
double calcbmr(double tall, double age, double wghie, String gender){
  double bmr=0;
  if (gender=='male'){
    bmr=88.36 + (13.4 * wghie) + (4.8 *tall) - (age*5.7);
  }
  else
    {
      bmr=447.6+(9.4*wghie)+(tall*3.1)-(age*4.3);

    }
return bmr;
}
double calloresneed(
double bmr,
String traning
)
{
  double calories=0;
  if(traning=="less traning 1-2 day")
  {
    calories=bmr*1.2;
  }
  else if(traning=="normal traning 1-3 day"){
    calories=bmr*1.55;
  }
  else if(traning=="hard traning 3-5 day"){
    calories=bmr*1.725;
  }
  else
    calories=bmr*1.9;

  return calories;

}

String BllodState(
    double calc,
    up,
    dwon,
    ){
  String blodpreserstate="";
  calc=(dwon + (up * 2)) / 3;
  if(calc<90){
    blodpreserstate='ضغط منخفض';
  }
  else if(calc>=90&&calc<=119){
    blodpreserstate='ضغط طبيعي';
  }
else
    blodpreserstate='ضغط مرتفع';

return blodpreserstate;
}

double BloodinBody(double wghite,double tall,String gender){
  double bloodinbody=0;
  if(gender=='male'){
    bloodinbody=(0.3669*wghite)+(0.03219*tall)+0.1833;

}
  else
    {bloodinbody=(0.3561 *wghite)+(0.03308 *tall)+0.1833;}
  return bloodinbody;
}
double SmookCost(double nseqaret,double nofseqaronpack,double costofpack) {

  double monthycost=0;

  double pack=nseqaret/nofseqaronpack;
  double dalycost=pack*costofpack;

  monthycost=dalycost*30;

  return monthycost;
}
double PerfectWight(double tall){
  double p;
  p=24*((tall*tall)*0.0001);
  return p;

}
double WaterInBody(double age,double wghite,double tall,String gender){
  double cal=0;
  if(gender=='male'){cal=(2.447 - (0.09145 *age)+(0.1074 *tall) + (0.3362*wghite))-(0.09516 );
      }
  else
    cal=(2.447 - (0.09145 *age)+(0.1074 *tall) + (0.3362*wghite));

  return cal;
}

double calcbmr1(double tall, double age, double wghie, String gender){
  double bmr=0;
  if (gender=='male'){
    bmr=66+ (13.7 * wghie) + (5 *tall) - (age*6.8);
  }
  else
  {
    bmr=655+(9.4*wghie)+(tall*9.6)-(age*4.7);

  }
  return bmr;
}
