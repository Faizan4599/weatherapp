import 'package:flutter/material.dart';
import 'package:weatherapp/constant/constant.dart';

showAlertDialog(BuildContext context, Function()? onPressed) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        title: const Text(
          Constant.appName,
          style: TextStyle(fontSize: 16),
        ),
        content:
            const Text('Please enable location permissions in device settings'),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'Ok',
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Back',
            ),
          ),
        ],
      );
    },
  );
}
