import 'package:BetterMe/ui/views/main_view/medicine_reminder/global_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:BetterMe/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../ui/views/main_view/medicine_reminder/constants.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
        value: globalBloc!,
        child: Sizer(builder: (context, orientation, deviceType) {
          return NeumorphicApp(
            themeMode: ThemeMode.light,
            theme: const NeumorphicThemeData(
              baseColor: Color(0xFFFFFFFF),
              lightSource: LightSource.topLeft,
              depth: 10,
            ),
            darkTheme: const NeumorphicThemeData(
              baseColor: Color(0xFF3E3E3E),
              lightSource: LightSource.topLeft,
              depth: 6,
            ),
            debugShowCheckedModeBanner: false,
            title: 'welcom to app laith',
            home: MainView(),
            builder: (context, child) {
              return GetMaterialApp(
                // theme: ThemeData.dark().copyWith(
                //   primaryColor: kPrimaryColor,
                //   scaffoldBackgroundColor: kScaffoldColor,
                //   //appbar theme
                //   appBarTheme: AppBarTheme(
                //     toolbarHeight: 7.h,
                //     backgroundColor: kScaffoldColor,
                //     elevation: 0,
                //     iconTheme: IconThemeData(
                //       color: kSecondaryColor,
                //       size: 20.sp,
                //     ),
                //     titleTextStyle: GoogleFonts.mulish(
                //       color: kTextColor,
                //       fontWeight: FontWeight.w800,
                //       fontStyle: FontStyle.normal,
                //       fontSize: 16.sp,
                //     ),
                //   ),
                //   textTheme: TextTheme(
                //     bodySmall: TextStyle(
                //       fontSize: 28.sp,
                //       color: kSecondaryColor,
                //       fontWeight: FontWeight.w500,
                //     ),
                //     headlineMedium: TextStyle(
                //       fontSize: 24.sp,
                //       fontWeight: FontWeight.w800,
                //       color: kTextColor,
                //     ),
                //     headlineLarge: TextStyle(
                //       fontSize: 16.sp,
                //       fontWeight: FontWeight.w900,
                //       color: kTextColor,
                //     ),
                //     headlineSmall: GoogleFonts.poppins(
                //       fontSize: 13.sp,
                //       color: kTextColor,
                //       fontWeight: FontWeight.w600,
                //       letterSpacing: 1.0,
                //     ),
                //     bodyMedium:
                //     GoogleFonts.poppins(fontSize: 15.sp, color: kPrimaryColor),
                //     bodyLarge:
                //     GoogleFonts.poppins(fontSize: 12.sp, color: kTextLightColor),
                //     displayMedium: GoogleFonts.poppins(
                //       fontSize: 9.sp,
                //       fontWeight: FontWeight.w400,
                //       color: kTextLightColor,
                //     ),
                //     labelMedium: TextStyle(
                //       fontSize: 10.sp,
                //       fontWeight: FontWeight.w500,
                //       color: kTextColor,
                //     ),
                //   ),
                //   inputDecorationTheme: const InputDecorationTheme(
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         color: kTextLightColor,
                //         width: 0.7,
                //       ),
                //     ),
                //     border: UnderlineInputBorder(
                //       borderSide: BorderSide(color: kTextLightColor),
                //     ),
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: kPrimaryColor),
                //     ),
                //   ),
                //   //lets customize the timePicker theme
                //   timePickerTheme: TimePickerThemeData(
                //     backgroundColor: kScaffoldColor,
                //     hourMinuteColor: kTextColor,
                //     hourMinuteTextColor: kScaffoldColor,
                //     dayPeriodColor: kTextColor,
                //     dayPeriodTextColor: kScaffoldColor,
                //     dialBackgroundColor: kTextColor,
                //     dialHandColor: kPrimaryColor,
                //     dialTextColor: kScaffoldColor,
                //     entryModeIconColor: kOtherColor,
                //     dayPeriodTextStyle: GoogleFonts.aBeeZee(
                //       fontSize: 8.sp,
                //     ),
                //   ),
                // ),
                builder: BotToastInit(),
                navigatorObservers: [BotToastNavigatorObserver()],
                debugShowCheckedModeBanner: false,
                home: child,
              );
            },
          );
        }));
  }
}
