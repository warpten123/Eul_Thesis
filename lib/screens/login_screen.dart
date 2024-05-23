import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/api_service/user_service.dart';

import 'package:thesis_eul/models/AccountModel.dart';

import 'package:thesis_eul/screens/student_Screens/code_screen.dart';
import 'package:thesis_eul/screens/student_Screens/register_screen.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/erika.dart';
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
  UserService get userService => GetIt.instance<UserService>();
  // ignore: unused_field
  late APIResponse<Account> _apiResponseAccount;
  // ignore: unused_field
  late APIResponse<Uint8List> _apiResponseProfile;
  late APIResponse<String> test;
  Future<APIResponse<bool>> userLogin(String id, String password) async {
    // ignore: unused_local_variable
    APIResponse<bool> response;
    return response = await userService.userLogin(id, password);
  }

  Future<APIResponse<Account>> getStudentByID(String id) async {
    return _apiResponseAccount = await userService.getStudentByID(id);
  }

  // ignore: non_constant_identifier_names
  Future<APIResponse<Uint8List>> getProfile(
      String schoold_id, String department) async {
    return _apiResponseProfile =
        await userService.getUserProfile(schoold_id, department);
  }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }
  final _formKey = GlobalKey<FormState>();
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
                  const Color(0xff161d27).withOpacity(0.9),
                  const Color(0xff161d27),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter ID';
                            }
                            return null;
                          },
                          controller: school_id,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "School ID",
                            labelStyle: TextStyle(color: Colors.grey.shade500),
                            // hintStyle: TextStyle(color: Colors.grey.shade500),
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
                        height: 12,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: const Color(0xff161d27).withOpacity(0.9),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Colors.green),
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
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                        // ignore: prefer_const_constructors
                        child: Text(
                          'No Account? Sign Up!',
                          style: const TextStyle(
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await userLogin(
                                  school_id.text, passwordController.text);
                              // var local = result;
                              print("RESULT : ${result.data}");
                              if (result.data != null) {
                                final result =
                                    await getStudentByID(school_id.text);

                                // ignore: use_build_context_synchronously
                                Account test = result.data!;

                                if (test.approve == 1) {
                                  // final result2 = await testFlask("a");
                                  // ignore: use_build_context_synchronously
                                  showSnackBarSuccess(
                                      context, "Welcome to EUL!");
                                  final resultUrl = await getProfile(
                                      school_id.text, test.departmentName!);
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDashboardNew(
                                            result.data!, resultUrl.data!)),
                                  );
                                  // ignore: use_build_context_synchronously
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Erika()),
                                  // );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showSnackBarError(context,
                                      "Your account is still pending confirmation.");
                                }
                              } else {
                                // ignore: use_build_context_synchronously
                                showSnackBarError(context,
                                    "Account doesn't exist! or Your account is still pending confirmation.");
                              }
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
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
