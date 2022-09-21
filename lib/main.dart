import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitopatologia_app/view/camera.dart';
import 'package:fitopatologia_app/view/home.view.dart';
import 'package:fitopatologia_app/view/profile.view.dart';
import 'package:fitopatologia_app/view/register.view.dart';
import 'package:fitopatologia_app/view/resultPage.view.dart';
import 'package:flutter/material.dart';
import 'package:fitopatologia_app/view/login.view.dart';

import 'view/home.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      
    options:  FirebaseOptions(
      apiKey: "AIzaSyAOHJEGbCezzhYH9JpzgiyosrB3YBPmPjE",
      authDomain: "diagplant.firebaseapp.com",
      databaseURL: "https://diagplant-default-rtdb.firebaseio.com",
      projectId: "diagplant",
      storageBucket: "diagplant.appspot.com",
      messagingSenderId: "461092039571",
      appId: "1:461092039571:web:ff37b2e6031c897d06d666",
      measurementId: "G-6JXD95B72F"
    )
      );
  runApp(FitoApp());
}

class FitoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auth.currentUser == null ? LoginView() : HomePage(),
      routes: {
        '/login': (context) => LoginView(),
        '/cadastro': (context) => RegisterView(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfileEditView(),
      },
    );
  }
}
