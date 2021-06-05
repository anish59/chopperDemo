import 'package:flutter/material.dart';

SnackBar showSnackBar(BuildContext context, {required String msg}) {
  final snackBar = SnackBar(
    content: Text(msg),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  return snackBar;
}
