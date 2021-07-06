/// Author : Sujith S A
/// Created on : 27th Apr 2021

/// This class acts as the controller class for both clock widget and the Home screen
/// It contains both Static and Observable objects
/// The clock animation logic is executed by using a time to pass 1/60th of a circle's value
/// every second into the CircularPercentIndicator widget's percent parameter, located
/// under clock.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:work_break/controllers/text_to_speech_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClockController extends GetxController {
  ClockController() {
    _clockAnimateTimer();
    Wakelock.enable();
  }

  final TextToSpeechController _textToSpeechController =
      Get.put(TextToSpeechController());

  RxDouble _secondsForAnimation = 0.0.obs;
  RxString _currentTimeToDisplay = ''.obs;
  RxString _amPmToDisplay = ''.obs;
  get currentTimeToDisplay => _currentTimeToDisplay.value;
  get secondsForAnimation => _secondsForAnimation.value;
  get amPmToDisplay => _amPmToDisplay.value;

  Timer _selectedWorkTimer;
  Timer _selectedIntervalTimer;
  Timer _testTimer;

  RxBool _firstLoad = true.obs;

  set setFirstLoad(val) {
    _firstLoad.value = val;
  }

  RxBool _changeInterval = false.obs;
  RxBool _clockThemeTrigger = false.obs;
  get clockThemeTrigger => _clockThemeTrigger.value;
  get changeInterval => _changeInterval.value;

  set setChangeIntervalValue(val) {
    _changeInterval.value = val;
  }

  RxBool _startWorkingTrigger = true.obs;

  get startWorkingTrigger => _startWorkingTrigger.value;

  set setStartWorkingTrigger(val) {
    _startWorkingTrigger.value = val;
  }

  set setClockThemeTriggerValue(val) {
    _clockThemeTrigger.value = val;
  }

  RxString _selectedWorkTime = ''.obs;
  RxString _selectedWorkInterval = ''.obs;

  get selectedWorkTime => _selectedWorkTime.value;
  get selectedWorkInterval => _selectedWorkInterval.value;

  set setWorkTime(val) {
    _selectedWorkTime.value = val;
  }

  set setIntervalTime(val) {
    _selectedWorkInterval.value = val;
  }

  int _timeForWorkTimer, _timeForIntervalTimer;

  _clockAnimateTimer() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _secondsForAnimation.value = DateTime.now().second / 60;
      _currentTimeToDisplay.value = DateFormat('hh:mm').format(DateTime.now());
      _amPmToDisplay.value = DateFormat(' a').format(DateTime.now());
    });
  }

  onClickStartWork(workTime, breakInterval) async {
    if (workTime == '' || breakInterval == '') {
      Get.snackbar(
        'Oops',
        'Please select the work and break times',
        duration: Duration(seconds: 3),
        colorText: Colors.black,
        backgroundColor: Colors.white,
      );
      await _textToSpeechController
          .speak(' Please select the work and break times first.');
    } else {
      setChangeIntervalValue = true;
      setStartWorkingTrigger = false;
      // if (_changeInterval.value == true) {
      // Get.snackbar(
      //   'Oops',
      //   'Toggle to apply settings',
      //   duration: Duration(seconds: 3),
      //   colorText: Colors.black,
      //   backgroundColor: Colors.white,
      // );
      // await _textToSpeechController.speak(
      //     'Your settings have already been applied. Just change it by toggling between the values');
      // } else {
      setClockThemeTriggerValue = true;
      Get.snackbar(
        'Success',
        'Start Working',
        duration: Duration(seconds: 3),
        colorText: Colors.black,
        backgroundColor: Colors.white,
      );
      await _textToSpeechController.speak(
          'Good job !!! Now you will be alerted for breaks based on your above '
          'settings. You can change it any time by toggling between the values');
      await _setUpTimer(workTime, breakInterval);
      // setChangeIntervalValue = true;
      // }
    }
  }

  onToggleValues(workTimeReminder, breakIntervalReminder) async {
    print('toggled WorkTime****' + workTimeReminder.toString());
    print('toggled IntervalTime****' + breakIntervalReminder.toString());
    Get.snackbar(
      'Hurray',
      'New settings applied',
      duration: Duration(seconds: 3),
      colorText: Colors.black,
      backgroundColor: Colors.white,
    );
    await _textToSpeechController.speak('Your new settings have been applied');
    _selectedWorkTimer.cancel();
    _selectedIntervalTimer.cancel();
    _testTimer.cancel();
    await _setUpTimer(workTimeReminder, breakIntervalReminder);
    _changeInterval.value = true;
  }

  _startTimer(int duration, String message, bool triggerFn) async {
    return Timer.periodic(Duration(minutes: duration), (Timer timer) async {
      await _textToSpeechController.speak(message);
      triggerFn ? _testTimer.cancel() : print('tester running');
      triggerFn
          ? _setUpTimer(_timeForWorkTimer, _timeForIntervalTimer)
          : print('No need to trigger ******');
      triggerFn ? _selectedIntervalTimer.cancel() : _selectedWorkTimer.cancel();
    });
  }

  _setUpTimer(workTimeReminder, breakIntervalReminder) async {
    if (workTimeReminder.toString().contains('min')) {
      _timeForWorkTimer = int.parse(workTimeReminder.toString().split(' ')[0]);
    } else {
      _timeForWorkTimer = workTimeReminder;
    }
    if (breakIntervalReminder.toString().contains('min')) {
      _timeForIntervalTimer =
          int.parse(breakIntervalReminder.toString().split(' ')[0]);
    } else {
      _timeForIntervalTimer = breakIntervalReminder;
    }
    print('timer set workTime****' + _timeForWorkTimer.toString());
    print('timer set intervalTime****' + _timeForIntervalTimer.toString());

    _selectedWorkTimer = await _startTimer(
        _timeForWorkTimer,
        'You have worked for ' +
            _timeForWorkTimer.toString() +
            ' minutes. Time to take a break.',
        false);

    _selectedIntervalTimer = await _startTimer(
        _timeForWorkTimer + _timeForIntervalTimer,
        'Your have taken a break for ' +
            _timeForIntervalTimer.toString() +
            ' minutes. Lets get back to work.',
        true);

    //Tester timer
    int i = 0;
    _testTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      print(i++);
    });
  }
}
