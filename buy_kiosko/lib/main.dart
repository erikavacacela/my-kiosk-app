import 'package:buy_kiosko/commons/home_page.dart';
import 'package:buy_kiosko/commons/login_page.dart';
import 'package:flutter/material.dart';
import 'package:buy_kiosko/utils/globals.dart' as globals;

void main() {
  runApp(KioskApp());
}

class KioskApp extends StatelessWidget {
  Map<dynamic, dynamic> currentUser = globals.currentUser;
  var isLoggedIn = globals.isLoggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget firstWidget;

    if (currentUser.isNotEmpty) {
      firstWidget = HomePage(title: 'Pagos en mi Kiosko');
    } else {
      firstWidget = LoginPage();
    }

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: firstWidget);
  }
}
