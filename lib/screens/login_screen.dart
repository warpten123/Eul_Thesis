import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:thesis_eul/models/AccountModel.dart';

import 'package:thesis_eul/screens/student_Screens/code_screen.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/new_user_dashboard.dart';
import 'package:thesis_eul/screens/utilities/utilities.dart';

import '../api_service/api_response.dart';
import '../api_service/research_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final auth = Authentication();
  // ignore: non_constant_identifier_names
  final school_id = TextEditingController();
  final passwordController = TextEditingController();
  ResearchService get resService => GetIt.instance<ResearchService>();
  late APIResponse<List<Account>> _apiResponse;
  late APIResponse<Account> _apiResponseAccount;

  Future<APIResponse<bool>> userLogin(String id, String password) async {
    APIResponse<bool> response;
    return response = await resService.userLogin(id, password);
  }

  Future<APIResponse<Account>> getStudentByID(String id) async {
    return _apiResponseAccount = await resService.getStudentByID(id);
  }

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
                  Color(0xff161d27).withOpacity(0.9),
                  Color(0xff161d27),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // ignore: prefer_const_constructors
                    Text(
                      "EUL",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 150,
                          fontWeight: FontWeight.bold),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Your Digital Research Repository System',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: TextField(
                        controller: school_id,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: "School ID",
                          labelStyle: TextStyle(color: Colors.grey.shade500),
                          // hintStyle: TextStyle(color: Colors.grey.shade500),
                          filled: true,
                          fillColor: Color(0xff161d27).withOpacity(0.9),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.grey.shade500),
                          filled: true,
                          fillColor: Color(0xff161d27).withOpacity(0.9),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CodeScreen()),
                        );
                      },
                      // ignore: prefer_const_constructors
                      child: Text(
                        'No Account? Enter Code!',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: TextButton(
                        onPressed: () {},
                        child: TextButton(
                          onPressed: () async {
                            // auth.signIn(emailController.text.trim(),
                            //     passwordController.text.trim());
                            final result = await userLogin(
                                school_id.text, passwordController.text);
                            // var local = result;
                            print("wtf ${result.data}");
                            if (result.data != null) {
                              final result =
                                  await getStudentByID(school_id.text);

                              // ignore: use_build_context_synchronously
                              showSnackBar(context, "Welcome to EUL!");
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserDashboardNew(result.data!)),
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              showSnackBar(context, "Account doesn't exist!");
                            }
                          },
                          // ignore: prefer_const_constructors
                          child: Text('SIGN IN',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
