import 'package:flutter/material.dart';

class Constant {
  static const regularHeadingStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black);

  static Future<void> showErrorDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Container(child: Text(message)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}
