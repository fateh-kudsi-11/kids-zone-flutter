import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/navigator/ios_bag_navigator.dart';
import '/navigator/ios_home_navigator.dart';
import '/navigator/ios_products_navigator.dart';
import '/navigator/ios_account_navigator.dart';
import '/navigator/ios_save_items_navigator.dart';
import '/providers/theme.dart';
import '/providers/bottom_navbar.dart';
import '/pages/style.dart';

class IOSBottonNavbar extends StatelessWidget {
  const IOSBottonNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    final tabController =
        Provider.of<BottomNavBarManger>(context).tabController;

    return CupertinoTabScaffold(
      controller: tabController,
      tabBar: CupertinoTabBar(
        height: 60,
        activeColor:
            themeDark ? const Color(0xffeeeeee) : const Color(0xff1f1f1f),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: 'Home',
            activeIcon: Icon(CupertinoIcons.house_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search_outlined),
            label: 'Search',
            activeIcon: Icon(Icons.manage_search),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bag),
            label: 'Bag',
            activeIcon: Icon(CupertinoIcons.bag_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Saved Items',
            activeIcon: Icon(CupertinoIcons.heart_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'My Account',
            activeIcon: Icon(CupertinoIcons.person_fill),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return const IOSHomeNavigator();
          case 1:
            return const IOSProductsNavigator();
          case 2:
            return const IOSBagNavigator();
          case 3:
            return const IOSSaveItemsNavigator();
          case 4:
            return const IOSAccountNavigator();
          default:
            return const MyHomePage();
        }
      },
    );
  }
}
