import 'dart:async';

import 'package:flutter/material.dart';

class ReenvioTimer extends StatefulWidget {
  const ReenvioTimer({
    Key? key,
  }) : super(key: key);

  @override
  _ReenvioTimerState createState() => _ReenvioTimerState();
}

class _ReenvioTimerState extends State<ReenvioTimer> {
  Timer? _timer;
  int counter = 30;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counter = 30 - timer.tick;
      if (timer.tick > 30) {
        counter = 0;
        timer.cancel();
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String parseNumber(int value) {
    if (value < 10) {
      return "0$value";
    }
    return "$value";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        counter == 0
            ? GestureDetector(
                onTap: () {
                  counter = 30;
                  setState(() {});

                  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                    counter = 30 - timer.tick;
                    if (timer.tick > 30) {
                      counter = 0;

                      timer.cancel();
                    }
                    if (mounted) {
                      setState(() {});
                    }
                  });
                },
                child: const Text(
                  "Reenviar SMS",
                ),
              )
            : Text(
                "Reenviar codigo en 00:${parseNumber(counter)}",
              ),
      ],
    );
  }
}
