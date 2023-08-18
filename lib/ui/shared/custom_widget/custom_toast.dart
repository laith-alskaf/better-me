import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:BetterMe/core/enums/message_type.dart';
import 'package:BetterMe/ui/shared/utils.dart';


class CustomToast {

  static showMessage(
      {required String message,
      MessageType? messageType = MessageType.INFO}) {
    String imageName = 'info';
    Color shadowColor = const Color.fromRGBO(187, 229, 169, 1);
    switch (messageType) {
      case MessageType.REJECTED:
        imageName = 'rejected-01';
        shadowColor = Colors.red.shade300;
        break;
      case MessageType.SUCCESS:
        imageName = 'approved1-01';
        shadowColor =  const Color.fromRGBO(187, 229, 169, 1);
        break;
      case MessageType.WARNING:
        imageName = 'warning';
        shadowColor = Colors.red;
        break;
      default:
        break;
    }
    BotToast.showCustomText(
        duration: const Duration(seconds: 3),
        toastBuilder: (value) {
          return Container(
            padding: const EdgeInsets.only(top: 5),
            width:screenWidth(1.3),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.6),
                    spreadRadius: 10,
                    blurRadius: 7,
                    offset: const Offset(0, 0),
                  )
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'images/$imageName.svg',
                  width: screenWidth(6),
                  color: Colors.red,
                  height: screenWidth(6),
                ),
                const SizedBox(height: 15,),
                Text(
                  message,
                  style: TextStyle(fontSize: screenWidth(18)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15,)
              ],
            ),
          );
        });
  }
}
