import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesis_eul/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
