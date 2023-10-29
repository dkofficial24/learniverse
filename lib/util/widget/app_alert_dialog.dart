import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.callback,
      this.positiveButtonText = 'Yes',
      this.negativeButtonText = 'No'});

  final String title;
  final String content;
  final Function callback;
  final String positiveButtonText;
  final String negativeButtonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(negativeButtonText)),
        TextButton(
            onPressed: () {
              callback();
              context.pop();
            },
            child: Text(positiveButtonText))
      ],
    );
  }
}
