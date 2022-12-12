import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/api_service/research_service.dart';

import 'package:thesis_eul/screens/login_screen.dart';
import 'package:thesis_eul/screens/student_Screens/user_dashboard.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => ResearchService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await di.init();
  // await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'LeonSans',
        primarySwatch: Colors.green,
      ),
      // home: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: ((context, snapshot) {
      //     if (snapshot.hasData) {
      //       return UserDashboard();
      //     } else {
      //       return LoginScreen();
      //     }
      //   }),
      home: LoginScreen(),

      debugShowCheckedModeBanner: false,
    );
  }
}
