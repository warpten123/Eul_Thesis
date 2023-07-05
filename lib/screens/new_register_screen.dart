// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/dialog.dart';
import 'package:thesis_eul/screens/utilities/utilities.dart';
import '../api_service/api_response.dart';
import '../api_service/file_service.dart';
import '../api_service/user_service.dart';
import '../models/AccountModel.dart';
import '../models/Files.dart';
import '../models/department.dart';
import '../models/school.dart';
import 'dart:core';

// ignore: camel_case_types
class New_Register_Screen extends StatefulWidget {
  const New_Register_Screen({super.key});

  @override
  State<New_Register_Screen> createState() => _New_Register_ScreenState();
}

// ignore: camel_case_types
class _New_Register_ScreenState extends State<New_Register_Screen> {
  UserService get userService => GetIt.instance<UserService>();
  int currentStep = 0;
  late APIResponse<List<Department>> _apiResponse;
  late APIResponse<List<School>> _apiResponseSchool;
  List<String> listSchools = [];
  List<String> listDepartment = [];
  List<String> globalDepartment = [];
  int indexSchool = 0;
  int? indexDept;
  bool display = false;
  bool _passwordVisible = true;
  bool _passwordVisible2 = true;
  File? image = null;
  bool go = false;
  bool init = true;
  int role = 0;
  String id = "";
  var baseName;
  @override
  void initState() {
    getSchool();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final fist_nameController = TextEditingController();
  final last_nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final emailController = TextEditingController();

  final school_Temp = TextEditingController();
  final dept_temp = TextEditingController();
  String? valueSchool = " ";
  String? valueDepartment = " ";
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

  Future<APIResponse<List<School>>> getAllSchools() async {
    return _apiResponseSchool = await userService.getAllSchools();
  }

  Future<APIResponse<List<Department>>> getDepartmentByID(int schoolId) async {
    return _apiResponse = await userService.getAllDepartmentsBySchool(schoolId);
  }

  Future<APIResponse<List<Department>>> getAllDeparments() async {
    return _apiResponse = await userService.getAllDepartments();
  }

  Future<APIResponse<bool>> addUserProfile(
      Files file, String department, String school, String accountID) async {
    APIResponse<bool> reponse;
    return reponse =
        await userService.addUserProfile(file, department, school, accountID);
  }

  Future<APIResponse<bool>> createAccount(Account account) async {
    APIResponse<bool> reponse;
    return reponse = await userService.createAccount(account);
  }

  Files uploadFunc(File files) {
    Files payload = Files(file: files.path, research_id: "1", url: image!.path);
    return payload;
  }

  void getSchool() async {
    listSchools = [];
    final result = await getAllSchools();
    for (int i = 0; i < result.data!.length; i++) {
      listSchools.add(result.data![i].schoolName);
    }
    valueSchool = listSchools.first;
  }

  void getDeptsBySchool(int indexSchool) async {
    listDepartment = [];
    final result = await getDepartmentByID(indexSchool);
    setState(() {
      for (int i = 0; i < result.data!.length; i++) {
        listDepartment.add(result.data![i].departmentName);
      }
      valueDepartment = listDepartment.first;
    });
  }

  void getAllDept() async {
    globalDepartment = [];
    final result = await getAllDeparments();
    print(result.data!.length);
    setState(() {
      for (int i = 0; i < result.data!.length; i++) {
        globalDepartment.add(result.data![i].departmentName);
      }
    });
  }

  showAlertDialogRegistration(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Register"),
      onPressed: () async {
        id = generateID();
        Navigator.pop(context);
        Files payload = uploadFunc(image!);
        print(
            "FOR PROFILE FILE: ${payload.file} DEPT: ${valueDepartment} SCHOOL: ${valueSchool} ID: $id");
        final addProfile =
            await addUserProfile(payload, valueDepartment!, valueSchool!, id);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogPopup(
                  "Registering Account...", "assets/loading_un_2.gif");
            });
        if (addProfile != null) {
          final account = Account(
              account_id: id,
              first_name: fist_nameController.text,
              last_name: last_nameController.text,
              email: emailController.text,
              password: passwordController.text,
              roleID: role,
              departmentName: valueDepartment,
              departmentID: indexDept!,
              approve: 0,
              image: baseName);

          final addAccount = await createAccount(account);

          if (addAccount.data != null) {
            // ignore: use_build_context_synchronously

            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            showSnackBarSuccess(context, "Account Successfully Registered!");
            Navigator.pop(context);
          } else {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            showSnackBarError(context, "Erro in registration!");
          }
        } else {
          print(addProfile.errorMessage);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Registration?"),
      content: Text("Done reviewing your information? Register it now!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
              child: Visibility(
                visible: init,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "First Step",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Your role",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 30,
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
                        onPressed: () {
                          setState(() {
                            init = false;
                            go = true;
                            role = 4;
                          });
                        },

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
                        onPressed: () {
                          setState(() {
                            init = false;
                            go = true;
                            role = 3;
                          });
                        },

                        // ignore: prefer_const_constructors
                        child: Text('TEACHER',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: go,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Register Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "You're very close from joining us!",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: Stepper(
                              controlsBuilder: (BuildContext context,
                                  ControlsDetails controls) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                );
                              },
                              type: StepperType.vertical,
                              steps: getSteps(context),
                              currentStep: currentStep,
                              onStepContinue: () {
                                final isLastStep =
                                    currentStep == getSteps(context).length - 1;
                                setState(() {
                                  if (isLastStep) {
                                  } else {
                                    currentStep += 1;
                                  }
                                });
                              },
                              onStepCancel: () {
                                setState(() {
                                  if (currentStep != 0) {
                                    currentStep -= 1;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Step> getSteps(context) => [
        Step(
            isActive: currentStep >= 0,
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: const Text(
              'Information',
              style: TextStyle(color: Colors.black),
            ),
            content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Text';
                          }
                          return null;
                        },
                        controller: fist_nameController,
                        decoration: InputDecoration(
                          labelText: "First Name",
                          labelStyle: TextStyle(color: Colors.grey.shade500),
                          // filled: true,
                          // fillColor: const Color(0xff161d27).withOpacity(0.9),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Text';
                          }
                          return null;
                        },
                        controller: last_nameController,
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          labelStyle: TextStyle(color: Colors.grey.shade500),
                          // filled: true,
                          // fillColor: const Color(0xff161d27).withOpacity(0.9),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "School Email",
                          labelStyle: TextStyle(color: Colors.grey.shade500),
                          // filled: true,
                          // fillColor: const Color(0xff161d27).withOpacity(0.9),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[\w-\.]+@usjr\.edu\.ph$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email ending with @usjr.edu.ph';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _passwordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),

                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.grey.shade500),
                          // filled: true,
                          // fillColor: const Color(0xff161d27).withOpacity(0.9),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: confirmController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Text';
                          }
                          return null;
                        },
                        obscureText: _passwordVisible2,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible2 = !_passwordVisible2;
                              });
                            },
                          ),
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: Colors.grey.shade500),
                          // filled: true,
                          // fillColor: const Color(0xff161d27).withOpacity(0.9),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                go = false;
                                init = true;
                              });
                            },
                            child: Icon(Icons.arrow_back, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              backgroundColor: Colors.green, // <-- Button color
                              foregroundColor: Colors.red, // <-- Splash color
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  if (confirmController.text ==
                                      passwordController.text) {
                                    currentStep++;
                                  } else {
                                    showSnackBarError(
                                        context, "Password doesn't match");
                                  }
                                }
                              });
                            },
                            child:
                                Icon(Icons.arrow_downward, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              backgroundColor: Colors.green, // <-- Button color
                              foregroundColor: Colors.red, // <-- Splash color
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ))),
        Step(
            isActive: currentStep >= 1,
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: const Text('School', style: TextStyle(color: Colors.black)),
            content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                        height: 50,
                        width: 500,
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                          // color: const Color(0xff161d27).withOpacity(0.9),
                          // borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.green),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: valueSchool,
                          onChanged: (value) {
                            setState(() {
                              indexSchool = 0;
                              valueSchool = value;
                              school_Temp.text = valueSchool!;
                              for (int i = 0; i < listSchools.length; i++) {
                                if (valueSchool == listSchools[i]) {
                                  indexSchool = i + 1;
                                }
                              }
                              print("SCHOOL $valueSchool INDEX $indexSchool");
                              getDeptsBySchool(indexSchool);
                              display = true;
                            });
                          },
                          items: listSchools.map(buildMenuItem).toList(),
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Visibility(
                      visible: display,
                      child: Container(
                          height: 50,
                          width: 500,
                          margin: const EdgeInsets.only(left: 40, right: 40),
                          decoration: BoxDecoration(
                            // color: const Color(0xff161d27).withOpacity(0.9),
                            // borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.green),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: valueDepartment,
                            onChanged: (value) {
                              setState(() {
                                indexDept = 0;

                                valueDepartment = value;
                                dept_temp.text = valueDepartment!;
                                print("LENGTH ${globalDepartment.length}");
                                for (int i = 0;
                                    i < globalDepartment.length;
                                    i++) {
                                  if (valueDepartment == globalDepartment[i]) {
                                    indexDept = i + 1;
                                  }
                                }
                                getAllDept();
                              });
                              print("VALUE DEPT: $valueDepartment $indexDept");
                            },
                            items: listDepartment.map(buildMenuItem).toList(),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentStep--;
                            });
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.green, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (valueSchool != " " &&
                                  valueDepartment != " ") {
                                currentStep++;
                              } else {
                                showSnackBarError(
                                    context, "Pick from the dropdown");
                              }
                              //
                            });
                          },
                          child:
                              Icon(Icons.arrow_downward, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.green, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                        )
                      ],
                    ),
                  ],
                ))),
        Step(
            isActive: currentStep >= 2,
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: const Text('Profile Picture',
                style: TextStyle(color: Colors.black)),
            content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        image = await FileService.pickFile();
                        setState(() {
                          if (image != null) {
                            baseName = basename(image!.path);
                          }
                        });
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(15),
                        padding: EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  image == null
                                      ? Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(),
                                          child: Icon(
                                            Icons.image,
                                            size: 50.0,
                                          ),
                                        )
                                      : Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(),
                                          child: Image.file(File(image!.path)),
                                        ),
                                  Text(
                                    "Image",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentStep--;
                            });
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.green, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (image != null) {
                                currentStep++;
                              } else {
                                showSnackBarError(context, "Pick an image!");
                              }
                            });
                          },
                          child:
                              Icon(Icons.arrow_downward, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.green, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                        )
                      ],
                    ),
                  ],
                ))),
        //step 4
        Step(
            isActive: currentStep > 3,
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: const Text('Review', style: TextStyle(color: Colors.black)),
            content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(15),
                      padding: EdgeInsets.all(6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                image == null
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(),
                                        child: Icon(
                                          Icons.image,
                                          size: 50.0,
                                        ),
                                      )
                                    : Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(),
                                        child: Image.file(File(image!.path)),
                                      ),
                                Text(
                                    "${fist_nameController.text} ${last_nameController.text}",
                                    style: TextStyle(fontSize: 19)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder()),
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: const InputDecoration(
                          labelText: 'School',
                          prefixIcon: Icon(Icons.location_city),
                          border: OutlineInputBorder()),
                      controller: school_Temp,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: const InputDecoration(
                          labelText: 'Department',
                          prefixIcon: Icon(Icons.school),
                          border: OutlineInputBorder()),
                      controller: dept_temp,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentStep--;
                            });
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.green, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showAlertDialogRegistration(context);
                            });
                          },
                          child: Icon(Icons.check, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.green, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                        )
                      ],
                    ),
                  ],
                ))),
      ];
}
