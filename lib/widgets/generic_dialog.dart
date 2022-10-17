import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class GenericDialog {
  VoidCallback onPressed;
  VoidCallback onReject;
  bool oneButton;
  Color color = const Color(0xFFE14949);
  bool isIcon = true;
  bool allBlue = false;
  bool barrierDismisible = false;

  String titulo = "ATENCIÓN";
  String opcion1 = "Sí";
  String opcion2 = "No";

  int iosv = 1;
  GenericDialog({
    Key? key,
    required this.onPressed,
    required this.onReject,
    this.titulo = "ATENCIÓN",
    this.isIcon = true,
    this.color = const Color(0xFFE14949),
    this.oneButton = false,
    this.allBlue = false,
    this.opcion1 = "Sí",
    this.opcion2 = "No",
    this.iosv = 1,
  });
  Future<void> show(context, content) async {
    return true
        ? showCupertinoDialog(
            context: context,
            barrierDismissible: barrierDismisible,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(titulo),
                content: content,
                actions: oneButton
                    ? <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: Text(iosv == 1 ? 'Ok' : 'Cerrar'),
                          onPressed: () {
                            onReject();
                          },
                        ),
                      ]
                    : <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          onPressed: onReject,
                          child: Text(opcion2),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: !allBlue,
                          onPressed: onPressed,
                          child: Text(opcion1),
                        )
                      ],
              );
            })
        : showDialog<void>(
            context: context,
            barrierDismissible: barrierDismisible,
            builder: (BuildContext context) {
              return AlertDialog(
                contentTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                title: Container(
                  height: 50,
                  color: color,
                  child: Center(
                    child: Text(
                      titulo,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                titlePadding: const EdgeInsets.all(0),
                titleTextStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
                // contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                contentPadding: const EdgeInsets.only(top: 20.0),
                actionsPadding: const EdgeInsets.all(0),
                actions: [
                  oneButton
                      ? TextButton(
                          onPressed: onReject,
                          child: Text(
                            "Cerrar",
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                      : Row(
                          children: [
                            TextButton(
                              onPressed: onPressed,
                              child: Text(
                                opcion1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: color),
                              ),
                            ),
                            TextButton(
                              onPressed: onReject,
                              child: Text(
                                opcion2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            )
                          ],
                        ),
                ],
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          isIcon
                              ? Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Lottie.asset(
                                        // Icons.error,
                                        // color: color,
                                        // size: 60.0,
                                        'assets/lottie/announcement.json',
                                        repeat: false),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: null,
                                ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: content,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
  }
}
