import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitopatologia_app/view/forgotPassword.view.dart';
import 'package:fitopatologia_app/view/home.view.dart';
import 'package:fitopatologia_app/view/onboarding.view.dart';
import 'package:fitopatologia_app/view/profile.view.dart';
import 'package:fitopatologia_app/view/register.view.dart';
//import 'package:fitopatologia_app/view/resultPage.view.dart';
import 'package:flutter/material.dart';
import 'package:fitopatologia_app/view/login.view.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'view/home.view.dart';

int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    /*options: const FirebaseOptions(
        apiKey: "AIzaSyAOHJEGbCezzhYH9JpzgiyosrB3YBPmPjE",
        authDomain: "diagplant.firebaseapp.com",
        databaseURL: "https://diagplant-default-rtdb.firebaseio.com",
        projectId: "diagplant",
        storageBucket: "diagplant.appspot.com",
        messagingSenderId: "461092039571",
        appId: "1:461092039571:web:ff37b2e6031c897d06d666",
        measurementId: "G-6JXD95B72F"),*/
  );

  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(FitoApp());
}

class FitoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String screen = '';
    if (initScreen == 0 || initScreen == null) {
      screen = 'onboarding';
    } else {
      if (auth.currentUser == null) {
        screen = '/login';
      } else {
        screen = '/home';
      }
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: auth.currentUser == null ? OnboardingView() : HomePage(),
      initialRoute: screen,
      routes: {
        '/login': (context) => LoginView(),
        '/cadastro': (context) => RegisterView(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfileEditView(),
        '/forgotPassword': (context) => ForgotPasswordView(),
        'onboarding': (context) => OnboardingView(),
      },
    );
  }
}
