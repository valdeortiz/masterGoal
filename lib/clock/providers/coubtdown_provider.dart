import 'dart:async';

import 'package:flutter/material.dart';

class CountdownProvider extends ChangeNotifier {
  Duration duration = const Duration(minutes: 5);
  // Duration duration = const Duration(seconds: 5);
  bool isRunning = false;
  StreamSubscription<int>? _tickSubscription;
  bool isWin = false;
  bool _modifyDuration = true;
  void startStopTimer() {
    if (!isRunning) {
      if (_modifyDuration) {
        _startTimer(duration.inSeconds);
      } else {
        _tickSubscription?.resume();
      }
      // _startTimer(const Duration(minutes: 5).inSeconds);
      // _startTimer(const Duration(seconds: 5).inSeconds);
    } else {
      _tickSubscription?.pause();
    }

    isRunning = !isRunning;
    notifyListeners();
  }

  // void pauseSub() => _tickSubscription?.pause();
  // void resumeSub() => _tickSubscription?.resume();

  void _startTimer(int seconds) {
    _modifyDuration = false;
    _tickSubscription?.cancel();
    _tickSubscription = Stream<int>.periodic(
            const Duration(seconds: 1), (val) => seconds - val - 1)
        .take(seconds)
        .listen((timeLeftInSeconds) {
      duration = Duration(seconds: timeLeftInSeconds);
      if (timeLeftInSeconds == 0) {
        // print("Tenemos un nuevo ganador");
        isRunning = false;
        isWin = true;
      }
      notifyListeners();
    });
  }

  void cancelTimer() {
    _tickSubscription?.cancel();
    isRunning = false;
    isWin = false;
  }

  void setCountdownDuration(Duration newDuration) {
    duration = newDuration;
    _tickSubscription?.cancel();
    isRunning = false;
    _modifyDuration = true;
    notifyListeners();
  }

  String get timeLeftString {
    final minutes =
        ((duration.inSeconds / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds =
        (duration.inSeconds % 60).floor().toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
