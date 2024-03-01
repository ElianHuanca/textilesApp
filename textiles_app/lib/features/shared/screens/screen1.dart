import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  final Widget widget;
  final String title;
  const Screen1({required this.widget, super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: widget,
    );
  }
}
