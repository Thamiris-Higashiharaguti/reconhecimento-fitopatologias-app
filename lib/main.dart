import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopatologia_app/view/cadastro.view.dart';
import 'package:fitopatologia_app/view/login.view.dart';

void main() async => runApp(FitoApp());

class FitoApp extends StatelessWidget {
  //final auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(), //auth.currentUser == null ? LoginView() : HomeView(),
      routes: {
        '/login':(context) => LoginView(),
        '/cadastro':(context) => CadastroView(),
      },
    );
  }
}
