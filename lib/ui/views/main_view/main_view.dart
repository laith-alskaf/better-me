import 'package:BetterMe/ui/views/main_view/medicine_reminder/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:BetterMe/ui/views/main_view/calculater/View/calculatthing/calcthing.dart';
import 'package:BetterMe/ui/shared/custom_widget/navigation_bar.dart';
import 'package:BetterMe/ui/views/main_view/home_view/home_view.dart';
import 'package:BetterMe/ui/views/main_view/search_screen_view/search_screen_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MainView extends StatefulWidget {
  int? currentIndexView;

  MainView({Key? key, this.currentIndexView}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetView = [
      const HomeView(),
      CalcPage(),
      const SearchScreen(),
      const HomePage(),
    ];

    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 8),
                child: NeumorphicText(
                  'BetterMe',
                  textAlign: TextAlign.start,
                  style: const NeumorphicStyle(
                    depth: 20,
                    intensity: -10, //customize depth here
                    color:
                        Color.fromRGBO(187, 229, 169, 1), //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              toolbarHeight: 70,
            ),
            bottomNavigationBar: NaviationBar(
              selectedIndex: widget.currentIndexView ?? 0,
              onIndexChanged: (index) {
                setState(() {
                  widget.currentIndexView = index;
                });
              },
            ),
            body: widgetView[widget.currentIndexView ?? 0]));
  }
// int CheckIndexView(){
//   return ViewCheck.getValue();
//
// }
}
