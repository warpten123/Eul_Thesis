import 'package:flutter/material.dart';

class First_Register extends StatefulWidget {
  const First_Register({super.key});

  @override
  State<First_Register> createState() => _First_RegisterState();
}

class _First_RegisterState extends State<First_Register> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/newback.jpg'),
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
                children: [
                  const Text(
                    "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "You're using this app as?",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    child: TextButton(
                      onPressed: () async {},

                      // ignore: prefer_const_constructors
                      child: Text('STUDENT',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    child: TextButton(
                      onPressed: () async {},

                      // ignore: prefer_const_constructors
                      child: Text('TEACHER',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
