import 'package:flutter/material.dart';

class SnackBars extends StatelessWidget {
  const SnackBars({Key? key}) : super(key: key);
  static void errorSnackBar(
      {required String content, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  static void notificationSnackBar(
      {required String content, required BuildContext context}) {
    Duration duration = const Duration(minutes: 1);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      duration: duration,
      // backgroundColor: Theme.of(context).errorColor,
      action: SnackBarAction(label: 'Ok', onPressed: () {}),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
