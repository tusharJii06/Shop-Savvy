import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertDiloag {
  static void showMyDiloag(
      {required BuildContext context,
        required String title,
        required String content,
        required Function() tabNo,
        required Function() tabYes}) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text("NO"),
              onPressed: tabNo,
            ),
            CupertinoDialogAction(
                child: const Text("YES"),
                isDestructiveAction: true,
                onPressed: tabYes
            )
          ],
        ));
  }
}