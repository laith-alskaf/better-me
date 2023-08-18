
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../color/AppColors.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({Key? key, required this.onpresed, required this.color}) : super(key: key);
  final Function onpresed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return ElevatedButton(onPressed: (){
      onpresed();
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
            backgroundColor: color,
            fixedSize: Size(double.infinity, size.width*0.1)
        )

    )
    ;
  }
}
