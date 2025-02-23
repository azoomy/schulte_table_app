import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schulte_table_app/constants/app_constants.dart';

class TableScreenController extends GetxController {
  int countdown = 3;
  int seconds = 0;
  int milliseconds = 0;
  Timer? timer;
  DateTime? startTime;
  bool viewCountdownPage = true;
  List<int> shuffledNumbers = [];
  int numberCheck = 0;
  int errorAtIndex = 0;
  DateTime? lastTapTime;
  Map<int, int> reactionTimesMap = {};

  // TODO: ADD ACCURACY CHECK


  @override
  void onInit() {
    startPageTimer();
    shuffleNumbers();
    super.onInit();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void refreshTable() {
    viewCountdownPage = true;
    countdown = 3;
    seconds = 0;
    milliseconds = 0;
    numberCheck = 0;
    errorAtIndex = 0;
    timer?.cancel();
    startTime = null;
    shuffleNumbers();
    update();
    startPageTimer();
    lastTapTime = null;
    reactionTimesMap.clear();
  }

  void shuffleNumbers() {
    shuffledNumbers = List<int>.generate(9, (index) => index + 1);
    shuffledNumbers.shuffle();
    update();
  }

  String get formattedTime => formatDuration(seconds, milliseconds);

  String formatDuration(int seconds, int milliseconds) {
    String secondsStr = (seconds % 60).toString();
    String millisecondsStr = milliseconds.toString().padLeft(3, '0');
    return '$secondsStr.$millisecondsStr';
  }

  void startPageTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (countdown > 1) {
        countdown--;
        update();
      } else {
        timer.cancel();
        viewCountdownPage = false;
        startTime = DateTime.now();
        startTimer();
        update();
        // Handle countdown completion here (e.g., navigate to next screen)
      }
      update();
    });
  }

  void startTimer() {
    const updateInterval = Duration(milliseconds: 10);
    timer = Timer.periodic(updateInterval, (Timer timer) {
      if (startTime != null) {
        var currentTime = DateTime.now();
        var difference = currentTime.difference(startTime!);
        seconds = difference.inSeconds;
        milliseconds = difference.inMilliseconds % 1000;
        update();
      }
    });
  }

  void numberCheckIncrement(context) {
    if (numberCheck < 9) {
      if (lastTapTime != null) {
        int reactionTime = DateTime.now().difference(lastTapTime!).inMilliseconds;
        reactionTimesMap[numberCheck + 1] = reactionTime; // Store with number
      }
      lastTapTime = DateTime.now();

      numberCheck++;
      errorAtIndex = 0;

      if (numberCheck == 9) {
        timer!.cancel();
        log("Reaction times per number: $reactionTimesMap");
        displayScoreDialog(context);
      }
      update();
    }
  }

  void displayScoreDialog(context) {
    if (reactionTimesMap.isEmpty) return;

    int slowestNumber = reactionTimesMap.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    int fastestNumber = reactionTimesMap.entries.reduce((a, b) => a.value < b.value ? a : b).key;

    int averageReaction = reactionTimesMap.values.reduce((a, b) => a + b) ~/ reactionTimesMap.length;
    int fastestReaction = reactionTimesMap.values.reduce((a, b) => a < b ? a : b);
    int slowestReaction = reactionTimesMap.values.reduce((a, b) => a > b ? a : b);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.lightColor,
          titlePadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          actionsPadding: EdgeInsets.only(bottom: 16, right: 12),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events, size: 30, color: AppColors.darkColor),
              SizedBox(height: 15),
              Text(
                'Your Time: $formattedTime',
                textAlign: TextAlign.center,
                style:AppTitles().statTime
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Performance Breakdown', style: AppTitles().subtitleDark),
              SizedBox(height: 10,),
              _buildStatRow('⚡ Avg Reaction:', '${averageReaction}ms'),
              Divider(color: AppColors.secondaryColor, thickness: 0.5),
              _buildStatRow('🚀 Fastest:', '${fastestReaction}ms (on $fastestNumber)'),
              Divider(color: AppColors.secondaryColor, thickness: 0.5),
              _buildStatRow('🐢 Slowest:', '${slowestReaction}ms (on $slowestNumber)'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.darkColor,
              ),
              child: Text('Home'),
            ),
            ElevatedButton(

              onPressed: () {
                Get.back();
                refreshTable();
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.black.withOpacity(0.3),
                elevation: 4,
                backgroundColor: AppColors.darkColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Retry'),
            ),
          ],
        );
      },
    );
  }
  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6), // More space
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTitles().stats),
          Text(value, style: AppTitles().statsValue),
        ],
      ),
    );
  }
  void setErrorForIndex(int index) {
    errorAtIndex = index;
    update();
  }

  Color gridColor(int gridIndex) {
    if (errorAtIndex == gridIndex) {
      return (numberCheck < gridIndex) ? Colors.red : Colors.green;
    } else {
      return (numberCheck >= gridIndex) ? Colors.green : AppColors.lightColor;
    }
  }
}
