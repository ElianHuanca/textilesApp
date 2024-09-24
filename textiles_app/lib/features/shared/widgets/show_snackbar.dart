import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showSnackbar(BuildContext context, String text) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.clearSnackBars();
  scaffoldMessenger.showSnackBar(
    SnackBar(content: Text(text)),
  );
}

void showSnackbarBool(BuildContext context, bool value) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.clearSnackBars();
  scaffoldMessenger.showSnackBar(
    SnackBar(
        content: Text(value ? 'Realizado Correctamente' : 'Hubo Un Error')),
  );
  if (Navigator.canPop(context)) {
    context.pop();
  }
}
