import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSizeText;
  final Color colorText;

  const CustomText(
      {Key? key,
      required this.text,
      required this.fontSizeText,
      required this.colorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget listOfText =  Text(
              text,
              style: TextStyle(
                fontSize: fontSizeText,
                color: Colors.black,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            );

    return listOfText;
  }
}
