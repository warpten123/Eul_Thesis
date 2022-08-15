import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thesis_eul/authentication/login.dart';
import 'package:thesis_eul/screens/code_screen.dart';
import 'package:thesis_eul/screens/user_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = Authentication();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/usjr2.jpg'),
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
                    "Adelante!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Need help with your thesis? Come sign in!',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: TextField(
                      controller: emailController,
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
                    height: 12,
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Password",
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
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CodeScreen()),
                      );
                    },
                    child: Text(
                      'No Account? Enter Code!',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
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
                    // child: TextButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const UserDashboard()),
                    //     );
                    //   },
                    child: TextButton(
                      onPressed: signIn,
                      child: Text('SIGN IN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                  // ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Research Adviser?',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '  Tap me!',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
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
    );
  }

  Future signIn() async {
    print("i am inside here");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
