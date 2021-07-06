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

  RxBool _clockThemeTrigger = false.obs;
  get clockThemeTrigger => _clockThemeTrigger.value;

  set setClockThemeTriggerValue(val) {
    _clockThemeTrigger.value = val;
  }

  RxBool _buttonChange = false.obs;
  get buttonChange => _buttonChange.value;

  set setButtonChange(val) {
    _buttonChange.value = val;
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
        'Please select both work and break times',
        duration: Duration(seconds: 3),
        colorText: Colors.black,
        backgroundColor: Colors.white,
      );
    } else {
      setClockThemeTriggerValue = true;

      Get.snackbar(
        'Success',
        _buttonChange.value == false
            ? 'Start Working'
            : 'Your new settings have been applied',
        duration: Duration(seconds: 3),
        colorText: Colors.black,
        backgroundColor: Colors.white,
      );
      _buttonChange.value == true
          ? _selectedWorkTimer.cancel()
          : print('Timer not active');
      _buttonChange.value == true
          ? _selectedIntervalTimer.cancel()
          : print('Timer not active');
      _buttonChange.value == true
          ? _testTimer.cancel()
          : print('Timer not active');
      setButtonChange = true;
      await _setUpTimer(_selectedWorkTime.value, _selectedWorkInterval.value);
      // }
    }
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
