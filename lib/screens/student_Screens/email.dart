import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesis_eul/screens/code_screen.dart';
import 'package:thesis_eul/screens/first_login.screen.dart';
import 'package:thesis_eul/screens/login_screen.dart';
import 'package:thesis_eul/screens/register_screen.dart';
import 'package:thesis_eul/screens/user_dashboard.dart';

import 'input_box.dart';

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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/usjr.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color(0xff161d27).withOpacity(0.9),
                    Color(0xff161d27),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "One step closer!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Check your email for verification code!',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "School Email",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          filled: true,
                          fillColor: Color(0xff161d27).withOpacity(0.9),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CodeScreen()),
                          );
                        },
                        child: Text('Send',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ),
                    SizedBox(
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
