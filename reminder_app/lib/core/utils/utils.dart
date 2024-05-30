import 'package:flutter/material.dart';

    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void showSnackBar(String text) {
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(content: Text(text),),
  // );
  final SnackBar snackBar = SnackBar(content: Text(text));
 scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}
