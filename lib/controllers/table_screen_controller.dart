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
    startTime = null; // Reset the start time
    shuffleNumbers();
    update();
    startPageTimer();
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
      numberCheck++;
      errorAtIndex = 0;
      if (numberCheck == 9) {
        timer!.cancel();
        log(formattedTime);
        displayScoreDialog(context);
      }
      update();
    }
  }

  void displayScoreDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.lightColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_events,
                size: 30,
                color: AppColors.darkColor,
              ),
              SizedBox(height: 10),
              Text(
                'Your Time is $formattedTime',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text(
                'Home',
                style: TextStyle(color: AppColors.darkColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                refreshTable();
              },
              child: Text(
                'Retry',
              ),
            ),
          ],
        );
      },
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
