// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:thesis_eul/authentication/login.dart';
// import 'package:thesis_eul/screens/login_screen.dart';

// import 'package:thesis_eul/screens/student_Screens/code_screen.dart';
// import 'package:thesis_eul/screens/teacher_Screens/teacher_code_screen.dart';
// import 'package:thesis_eul/screens/teacher_Screens/teacher_dashboard.dart';

// class TeacherLogin extends StatefulWidget {
//   const TeacherLogin({Key? key}) : super(key: key);

//   @override
//   State<TeacherLogin> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<TeacherLogin> {
//   final auth = Authentication();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   // @override
//   // void dispose() {
//   //   emailController.dispose();
//   //   passwordController.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('assets/basak2.jpg'),
//                       fit: BoxFit.cover)),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   Colors.transparent,
//                   Colors.transparent,
//                   Color(0xff161d27).withOpacity(0.9),
//                   Color(0xff161d27),
//                 ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//               ),
//             ),
//             Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Text(
//                       "Welcome Adviser!",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 38,
//                           fontWeight: FontWeight.bold),
//                     ),

//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       height: 50,
//                       margin: EdgeInsets.only(left: 40, right: 40),
//                       child: TextField(
//                         controller: emailController,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "School Email",
//                           hintStyle: TextStyle(color: Colors.grey.shade500),
//                           filled: true,
//                           fillColor: Color(0xff161d27).withOpacity(0.9),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide(color: Colors.green),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     Container(
//                       height: 50,
//                       margin: EdgeInsets.only(left: 40, right: 40),
//                       child: TextField(
//                         controller: passwordController,
//                         obscureText: true,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "Password",
//                           hintStyle: TextStyle(color: Colors.grey.shade500),
//                           filled: true,
//                           fillColor: Color(0xff161d27).withOpacity(0.9),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide(color: Colors.green),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const TeacherCodeScreen()),
//                         );
//                       },
//                       child: Text(
//                         'No Account? Enter Code!',
//                         style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 50,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                       ),
//                       margin: EdgeInsets.only(left: 40, right: 40),
//                       // child: TextButton(
//                       //   onPressed: () {
//                       //     Navigator.push(
//                       //       context,
//                       //       MaterialPageRoute(
//                       //           builder: (context) => const UserDashboard()),
//                       //     );
//                       //   },

//                       child: TextButton(
//                         onPressed: () {
//                           // auth.signIn(emailController.text.trim(),
//                           //     passwordController.text.trim());
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => TeacherDashboard()),
//                           );
//                         },
//                         child: Text('SIGN IN',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18)),
//                       ),
//                     ),
//                     // ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           SizedBox(
//                             height: 15,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const LoginScreen()),
//                               );
//                             },
//                             child: Text(
//                               'Go Back',
//                               style: TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
