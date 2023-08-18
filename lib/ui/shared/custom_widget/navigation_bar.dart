import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NaviationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onIndexChanged;

  const NaviationBar(
      {Key? key, required this.onIndexChanged, required this.selectedIndex})
      : super(key: key);

  @override
  State<NaviationBar> createState() => _NaviationBarState();
}

class _NaviationBarState extends State<NaviationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              haptic: false,
              // debug: true,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: const Color.fromRGBO(187, 229, 169, 1),
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.black45,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.calculate,
                  text: 'Calculate',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Ask Me',
                ),
                GButton(
                  hoverColor: Colors.blue,
                  icon: Icons.notifications_active_outlined,
                  text: 'Reminder',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  widget.onIndexChanged(index);
                  _selectedIndex = index;
                  ViewCheck.updateValue(_selectedIndex);
                });
              },
            ),
          ),
        ));
  }
}

class ViewCheck {
  static int hhh = 0;

  static int updateValue(int indexVIew) {
    hhh = indexVIew;
    return hhh;
  }

  static int getValue() {
    return hhh;
  }
}
