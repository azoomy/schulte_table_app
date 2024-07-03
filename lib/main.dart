import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schulte_table_app/constants/app_constants.dart';
import 'package:schulte_table_app/firebase_options.dart';
import 'package:schulte_table_app/routes/routes.dart';
import 'package:schulte_table_app/screens/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.pages,
      theme: _buildTheme(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.lightColor,
        onPrimary: AppColors.lightColor,
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.mainColor,
        error: Colors.red,
        onError: Colors.red,
        background: AppColors.darkColor,
        onBackground: AppColors.darkColor,
        surface: AppColors.secondaryColor,
        onSurface: AppColors.secondaryColor,
      ),
      useMaterial3: true,
      textTheme: GoogleFonts.soraTextTheme(),
    );
  }
}
