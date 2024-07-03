import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schulte_table_app/constants/app_constants.dart';
import 'package:schulte_table_app/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.scaffoldColor),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.width * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(''),
                    ),
                    true
                        ? TextButton(
                            onPressed: () {},
                            child: const Text('Sign in'),
                          )
                        : CircleAvatar(
                            child: Icon(
                              Icons.person_2_outlined,
                              color: AppColors.darkColor,
                            ),
                          ),
                    // Text(
                    //   'Sign in',
                    //   style: AppTitles().subtitle,
                    // ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(
                  child: Text(
                    'Welcome back, Azeem.',
                    style: AppTitles().header,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                // const Spacer(),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        MdiIcons.brain,
                        size: size.height * 0.175,
                        color: AppColors.lightColor,
                      ),
                      Text(
                        'Schulte Table',
                        style: AppTitles().header,
                      ),
                      Text(
                        'See Faster, Think Smarter, React Quicker.',
                        style: AppTitles().text,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        'Play',
                        style: AppTitles().subtitle,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.01),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightColor,
                                foregroundColor: AppColors.darkColor),
                            onPressed: () {
                              Get.toNamed(Routes.getTableScreen());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.bar_chart),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                const Text('3 x 3 Table'),
                              ],
                            )),
                      ),
                      // Text(
                      //   'Other game modes are coming soon!',
                      //   style: AppTitles().text,
                      // ),
                      // Text('3x3'),
                      // Text('Play'),
                      // Text('Play'),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                const Spacer(),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '©️ All Rights Reserved.',
                        style: AppTitles().footer,
                      ),
                      Text(
                        'v 0.0.1 (1)',
                        style: AppTitles().footer,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
