import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:madadgarvirus/utils/app_constants.dart';
import 'package:madadgarvirus/utils/helper.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onIndexChange,
  }) : super(key: key);

  final int selectedIndex;
  final void Function(int index) onIndexChange;
  @override
  Widget build(BuildContext context) {
    return FlashyTabBar(
      selectedIndex: selectedIndex,
      backgroundColor: kDarkerColor,
      onItemSelected: (index) => onIndexChange.call(index),
      height: 65,
      iconSize: 25,
      items: [
        FlashyTabBarItem(
          icon: const Icon(Icons.home),
          title: Text(
            str.navBarHome,
            style: const TextStyle(fontSize: 15),
          ),
          activeColor: Colors.white,
          inactiveColor: Colors.white30,
        ),
        FlashyTabBarItem(
          icon: const Icon(Icons.add_box),
          title: Text(
            str.navAdd,
            style: const TextStyle(fontSize: 15),
          ),
          activeColor: Colors.white,
          inactiveColor: Colors.white30,
        ),
        FlashyTabBarItem(
          icon: const Icon(Icons.newspaper),
          title: Text(
            str.navBarArticals,
            style: const TextStyle(fontSize: 15),
          ),
          activeColor: Colors.white,
          inactiveColor: Colors.white30,
        ),
        FlashyTabBarItem(
          icon: const Icon(Icons.mail),
          title: Text(
            str.navBarRequests,
            style: const TextStyle(fontSize: 15),
          ),
          activeColor: Colors.white,
          inactiveColor: Colors.white30,
        ),
        FlashyTabBarItem(
          icon: const Icon(Icons.person),
          title: Text(
            str.navBarProfile,
            style: const TextStyle(fontSize: 15),
          ),
          activeColor: Colors.white,
          inactiveColor: Colors.white30,
        ),
      ],
    );
  }
}

// child: GNav(
//   gap: 8.0,
//   backgroundColor: kDarkerColor,
//   color: kDarkColor,
//   activeColor: kDarkerColor,
//   tabBackgroundColor: kLightColor,
//   selectedIndex: selectedIndex,
//   onTabChange: (index) => onIndexChange.call(index),
//   padding: const EdgeInsets.all(16),
//   tabs: const [
//     GButton(
//       icon: Icons.home,
//       //text: str.navBarHome,
//     ),
//     GButton(
//       icon: Icons.newspaper,
//       //text: str.navBarArticals,
//     ),
//     GButton(
//       icon: Icons.newspaper,
//       //text: str.navBarArticals,
//     ),
//     GButton(
//       icon: Icons.mail,
//       //text: str.navBarRequests,
//     ),
//     GButton(
//       icon: Icons.person,
//       //text: str.navBarProfile,
//     ),
//   ],
// ),
