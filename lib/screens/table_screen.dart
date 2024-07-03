import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schulte_table_app/constants/app_constants.dart';
import 'package:schulte_table_app/controllers/table_screen_controller.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TableScreenController());
    return Scaffold(
      body: GetBuilder<TableScreenController>(
        builder: (controller) => _buildContent(controller, context),
      ),
    );
  }

  Widget _buildContent(TableScreenController controller, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int crossAxisCount = 3;

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppColors.scaffoldColor),
      child: SafeArea(
        child:_buildTablePage(context, controller, size, crossAxisCount),
      ),
    );
  }

  Widget _buildCountdownPage(TableScreenController controller, Size size) {
    return Center(
      child: Text(
        controller.countdown.toString(),
        style: TextStyle(
          color: AppColors.lightColor,
          fontWeight: FontWeight.w100,
          fontSize: size.height * 0.25,
        ),
      ),
    );
  }

  Widget _buildTablePage(BuildContext context, TableScreenController controller,
      Size size, int crossAxisCount) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                // onPressed: controller.refreshTable,
                onPressed: () {
                  controller.displayScoreDialog(context);
                },
                icon: Icon(
                  Icons.refresh,
                  color: AppColors.lightColor,
                  size: size.height * 0.04,
                ),
              )
            ],
          ),
          SizedBox(height: size.height * 0.1),
          _buildTimerDisplay(controller, size),
          SizedBox(height: size.height * 0.02),
          controller.viewCountdownPage ? _buildCountdownPage(controller, size) :
          _buildGridView(controller, crossAxisCount),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildTimerDisplay(TableScreenController controller, Size size) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: size.width * 0.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.av_timer,
                  size: 36,
                  color: AppColors.lightColor,
                ),
                SizedBox(width: size.width * 0.01),
                Text(
                  controller.formattedTime,
                  style: AppTitles().header,
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Choose a grid from 1 to 9 and complete it in ascending order, quickly!',
            style: TextStyle(
                color: AppColors.lightColor,
                fontWeight: FontWeight.w500,
                fontSize: size.height * 0.013),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(TableScreenController controller, int crossAxisCount) {
    return Center(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: crossAxisCount * crossAxisCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          BorderRadius borderRadius = _getBorderRadius(index, crossAxisCount);
          int number = controller.shuffledNumbers[index];

          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (_) {
              if (controller.numberCheck + 1 == number) {
                controller.numberCheckIncrement(context);
              } else {
                controller.setErrorForIndex(number);
              }
            },
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Container(
                decoration: BoxDecoration(
                  color: controller.gridColor(number),
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: AppTitles().tableNumber,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isCornerCell(int index, int crossAxisCount) {
    return (index == 0 ||
        index == crossAxisCount - 1 ||
        index == crossAxisCount * (crossAxisCount - 1) ||
        index == crossAxisCount * crossAxisCount - 1);
  }

  BorderRadius _getBorderRadius(int index, int crossAxisCount) {
    BorderRadius borderRadius = BorderRadius.zero;
    if (_isCornerCell(index, crossAxisCount)) {
      if (index == 0) {
        borderRadius = const BorderRadius.only(topLeft: Radius.circular(15.0));
      } else if (index == crossAxisCount - 1) {
        borderRadius = const BorderRadius.only(topRight: Radius.circular(15.0));
      } else if (index == crossAxisCount * (crossAxisCount - 1)) {
        borderRadius =
            const BorderRadius.only(bottomLeft: Radius.circular(15.0));
      } else if (index == crossAxisCount * crossAxisCount - 1) {
        borderRadius =
            const BorderRadius.only(bottomRight: Radius.circular(15.0));
      }
    }
    return borderRadius;
  }
}
