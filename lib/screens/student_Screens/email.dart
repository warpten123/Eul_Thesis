import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';

import 'package:thesis_eul/screens/student_Screens/code_screen.dart';


class EmailScreen extends StatelessWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/usjr.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.transparent,
                    const Color(0xff161d27).withOpacity(0.9),
                    const Color(0xff161d27),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const Text(
                      "One step closer!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Check your email for verification code!',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 40, right: 40),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "School Email",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          filled: true,
                          fillColor: const Color(0xff161d27).withOpacity(0.9),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      margin: const EdgeInsets.only(left: 40, right: 40),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CodeScreen()),
                          );
                        },
                        child: const Text('Send',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
