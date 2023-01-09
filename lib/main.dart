import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/api_service/file_service.dart';
import 'package:thesis_eul/api_service/research_service.dart';
import 'package:thesis_eul/api_service/user_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thesis_eul/screens/login_screen.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => ResearchService());
  GetIt.instance.registerLazySingleton(() => UserService());
  GetIt.instance.registerLazySingleton(() => FileService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await di.init();
  // await Firebase.initializeApp();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EUL',
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
      home: const LoginScreen(),
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en', 'US'),
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
