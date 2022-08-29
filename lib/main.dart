import 'package:flutter/material.dart';
import 'package:fitopatologia_app/view/login.view.dart';

void main() {
  runApp(const FitoApp());
}

class FitoApp extends StatelessWidget {
  const FitoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}
