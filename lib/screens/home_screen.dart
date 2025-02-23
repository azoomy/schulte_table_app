import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schulte_table_app/constants/app_constants.dart';
import 'package:schulte_table_app/controllers/home_controller.dart';
import 'package:schulte_table_app/controllers/login_controller.dart';
import 'package:schulte_table_app/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final homeController = Get.put(HomeController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(gradient: AppColors.scaffoldColor),
            child: SafeArea(
              child: controller.loading
                  //TODO: add loader
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    children: [
                      Expanded(child: _buildContent(size, controller, context)),
                      buildAdBanner(homeController),
                    ],
                  ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAdBanner(HomeController homeController) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (!controller.isHomeAdLoaded || controller.homeBannerAd == null) {
          return const SizedBox(); // Hide if not loaded
        }
        return Container(
          alignment: Alignment.center,
          width: controller.homeBannerAd!.size.width.toDouble(),
          height: controller.homeBannerAd!.size.height.toDouble(),
          child: AdWidget(ad: controller.homeBannerAd!),
        );
      },
    );
  }

  Widget _buildContent(
      Size size, LoginController controller, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.width * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // _buildSignInButton(controller, context),
              SizedBox(height: 20,),
            ],
          ),
          SizedBox(height: size.height * 0.05),
          _buildWelcomeText(size, controller),
          SizedBox(height: size.height * 0.1),
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
                SizedBox(height: size.height * 0.05),
                Text(
                  'Play',
                  style: AppTitles().subtitle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightColor,
                      foregroundColor: AppColors.darkColor,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.getTableScreen());
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bar_chart),
                        SizedBox(width: 8),
                        Text('3 x 3 Table'),
                      ],
                    ),
                  ),
                ),
                // TextButton(
                //   // style: ElevatedButton.styleFrom(
                //   //   backgroundColor: AppColors.lightColor,
                //   //   foregroundColor: AppColors.darkColor,
                //   // ),
                //   onPressed: () {
                //     Get.toNamed(Routes.getScoreboardScreen());
                //   },
                //   child: const Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Icon(Icons.emoji_events),
                //       SizedBox(width: 8),
                //       Text('Scoreboard'),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Add your coffee link handling logic here
                  },
                  child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                MdiIcons.coffeeOutline,
                color: AppColors.coffeeColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Buy Me a Coffee',
                style: AppTitles().coffeeText,
              ),
            ],
          ),
                ),
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
    );
  }

  Widget _buildSignInButton(LoginController controller, BuildContext context) {
    return controller.user == null
        ? TextButton(
            onPressed: () async {
              await controller.signInWithGoogle();
            },
            child: const Text('Sign in'),
          )
        : TextButton(
            onPressed: () async {
              controller.showLogoutDialog(context);
            },
            child: const Text('Logout'),
          );
  }

  Widget _buildWelcomeText(Size size, LoginController controller) {
    return Center(
      child:
      // controller.userName == ""
      //     ?
      Text(
              "Time to sharpen your brain.",
              style: AppTitles().header,
              textAlign: TextAlign.center,
            )
          // : Text(
          //     "Time to sharpen your brain, ${controller.userName}!",
          //     style: AppTitles().header,
          //     textAlign: TextAlign.center,
          //   ),
    );
  }
}
