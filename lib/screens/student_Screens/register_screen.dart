import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/api_service/file_service.dart';
import 'package:thesis_eul/api_service/user_service.dart';
import 'package:thesis_eul/models/department.dart';

import 'package:thesis_eul/screens/login_screen.dart';
import 'package:thesis_eul/screens/student_Screens/user_dashboard.dart';
import 'package:thesis_eul/screens/utilities/utilities.dart';
import 'package:path/path.dart';
import '../../api_service/api_response.dart';
import '../../api_service/research_service.dart';
import '../../models/AccountModel.dart';
import '../../models/Files.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ignore: non_constant_identifier_names
  final fist_nameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final last_nameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final email_Controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final password_Controller = TextEditingController();
  File? image = null;
  String pass = "";
  var baseName;
  List<String> deparments = [
    "School of Computer Studies",
    "School of Allied Medicine",
    "School of Arts and Sciences",
    "School of Law",
    "School of Business Administration",
    "School of Engineering",
    "School of Education"
  ];
  ResearchService get resService => GetIt.instance<ResearchService>();
  UserService get userService => GetIt.instance<UserService>();
  FileService get fileService => GetIt.instance<FileService>();
  late APIResponse<List<Department>> _apiResponse;
  Future<APIResponse<bool>> createAccount(Account account) async {
    APIResponse<bool> reponse;
    return reponse = await userService.createAccount(account);
  }

  Future<APIResponse<bool>> addUserProfile(Files file) async {
    APIResponse<bool> reponse;
    return reponse = await userService.addUserProfile(file);
  }

  Future<APIResponse<List<Department>>> getAllDepartments() async {
    return _apiResponse = await userService.getAllDepartments();
  }

  Files uploadFunc(File files) {
    Files payload =
        Files(file: files.path, research_id: pass, url: image!.path);
    return payload;
  }

  final _formKey = GlobalKey<FormState>();
  String? valueDropDown;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey.shade500),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/usjr2.jpg'),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text(
                        "Register Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "You're one step away from joining us!",
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Text';
                            }
                            return null;
                          },
                          controller: fist_nameController,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "First Name",
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
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Text';
                            }
                            return null;
                          },
                          controller: last_nameController,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Last Name",
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
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Text';
                            }
                            return null;
                          },
                          controller: email_Controller,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "School Email",
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
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Text';
                            }
                            return null;
                          },
                          controller: password_Controller,
                          obscureText: true,
                          style: const TextStyle(
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
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 40, right: 40),
                          decoration: BoxDecoration(
                            color: const Color(0xff161d27).withOpacity(0.9),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.green),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: valueDropDown,
                            onChanged: (value) {
                              setState(() {
                                valueDropDown = value;
                              });
                            },
                            items: deparments.map(buildMenuItem).toList(),
                          )),
                      const SizedBox(
                        height: 15,
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
                          onPressed: () async {
                            image = await FileService.pickFile();
                            setState(() {
                              baseName = basename(image!.path);
                            });
                          },
                          child: image == null
                              ? const Text('Pick Profile Picture',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))
                              : Text('$baseName',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (image != null && valueDropDown != null) {
                                int deptID = 0;
                                final resultDept = await getAllDepartments();
                                List<Department> department;
                                department = resultDept.data!;
                                for (int i = 0; i < department.length; i++) {
                                  if (department[i].departmentName ==
                                      valueDropDown) {
                                    deptID = department[i].departmentID;
                                  }
                                }
                                pass = generatePassword();
                                final account = Account(
                                  school_id: pass,
                                  first_name: fist_nameController.text,
                                  last_name: last_nameController.text,
                                  email: email_Controller.text,
                                  password: password_Controller.text,
                                  role_roleID: 4,
                                  departmentID: deptID,
                                  approve: 1,
                                );

                                final result = await createAccount(account);
                                if (result.data != null) {
                                  // ignore: use_build_context_synchronously
                                  showSnackBarSucess(
                                      context, "Registered Successfully!");
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showSnackBarError(
                                      context, result.errorMessage.toString());
                                }
                                Files payload = uploadFunc(image!);
                                final resultAvatar =
                                    await addUserProfile(payload);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const UserDashboard()),
                                // );
                              } else {
                                showSnackBarError(
                                    context, "Registration Error!");
                              }
                            }
                          },
                          child: const Text('REGISTER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Take me back!',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
