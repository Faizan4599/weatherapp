import 'package:flutter/material.dart';
import 'package:weatherapp/constant/constant.dart';

void showLocationDialog(BuildContext context,
    {String? title,
    String? content,
    Function()? onPressed,
    String? buttonTitle}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(title ?? "Alert"),
      content: Text(content ?? ""),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(buttonTitle ?? "Ok"),
        ),
      ],
    ),
  );
}
