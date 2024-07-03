import 'dart:io';

import 'package:get/get.dart';
import 'package:schulte_table_app/screens/home_screen.dart';
import 'package:schulte_table_app/screens/table_screen.dart';

class Routes {
  static String mainScreen = "/";
  static String tableScreen = "/table-screen";

  static String getMainScreen() => mainScreen;
  static String getTableScreen() => tableScreen;

  static List<GetPage> pages = [
    GetPage(
      name: mainScreen,
      page: () => const HomeScreen(),
      transition: Platform.isIOS ? Transition.cupertino : Transition.topLevel,
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: tableScreen,
      page: () => TableScreen(),
      transition: Platform.isIOS ? Transition.cupertino : Transition.topLevel,
      binding: BindingsBuilder(() {}),
    ),
  ];
}
