import 'dart:io';

import 'package:get/get.dart';
import 'package:schulte_table_app/screens/home_screen.dart';
import 'package:schulte_table_app/screens/scoreboard_screen.dart';
import 'package:schulte_table_app/screens/table_screen.dart';

class Routes {
  static String mainScreen = "/";
  static String tableScreen = "/table-screen";
  static String scoreboardScreen = "/scoreboard-screen";

  static String getMainScreen() => mainScreen;
  static String getTableScreen() => tableScreen;
  static String getScoreboardScreen() => scoreboardScreen;

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
    GetPage(
      name: scoreboardScreen,
      page: () => const ScoreboardScreen(),
      transition: Platform.isIOS ? Transition.cupertino : Transition.topLevel,
      binding: BindingsBuilder(() {}),
    ),
  ];
}
