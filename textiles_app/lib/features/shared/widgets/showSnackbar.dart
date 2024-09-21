// ignore_for_file: file_names

import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.clearSnackBars();
  scaffoldMessenger.showSnackBar(
    SnackBar(content: Text(text)),
  );
  /* ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  ); */
}

void showSnackbarBool(BuildContext context, bool value) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.clearSnackBars();
  scaffoldMessenger.showSnackBar(
    SnackBar(
        content: Text(value ? 'Realizado Correctamente' : 'Hubo Un Error')),
  );
}
