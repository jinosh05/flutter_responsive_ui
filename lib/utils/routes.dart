import "package:flutter/material.dart";

class AppRoutes {
  AppRoutes();
  static Future<void> push(BuildContext context, Widget page) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<void> replace(BuildContext context, Widget page) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<void> makeFirst(BuildContext context, Widget page) async {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void dismissAlert(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Future<void> pushAndRemove(BuildContext context, Widget page) async {
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
