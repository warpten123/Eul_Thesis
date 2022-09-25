// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:thesis_eul/models/class.dart';
// import 'package:thesis_eul/models/res_categories.dart';
// import 'package:thesis_eul/models/research.dart';
// import 'package:thesis_eul/screens/student_Screens/research_screen.dart';
// import 'package:thesis_eul/screens/teacher_Screens/teacher_login.dart';

// class TeacherDashboard extends StatefulWidget {
//   TeacherDashboard({Key? key}) : super(key: key);

//   @override
//   State<TeacherDashboard> createState() => _ContentUserDashBoardState();
// }

// class _ContentUserDashBoardState extends State<TeacherDashboard> {
//   bool checkbox = false;

//   List<Categories> categories = [
//     Categories(title: 'All', image: 'assets/vision.jpg', count: 4),
//     Categories(
//         title: 'Artificial Intelligence', image: 'assets/ai.png', count: 2),
//     Categories(title: 'Machine Learning', image: 'assets/ml.png', count: 2),
//     Categories(title: 'Computer Vision', image: 'assets/vision.jpg', count: 4),
//   ];

//   List<Research> research = [
//     Research(
//         title: 'Eul: An Intelligent Research Repository Management',
//         image: 'assets/cover_page.jpg',
//         department: 'School Of Computer Studies',
//         authors: ['Bohol', 'Premacio']),
//     Research(
//         title: 'A Research Title',
//         image: 'assets/cover_page.jpg',
//         department: 'School Of Computer Studies',
//         authors: ['Cuizon', 'Gadiane']),
//     Research(
//         title: 'Another Research Title',
//         image: 'assets/cover_page.jpg',
//         department: 'School Of Computer Studies',
//         authors: ['Patalita', 'Bandalan']),
//     Research(
//         title: 'StudyUp',
//         image: 'assets/cover_page.jpg',
//         department: 'School Of Computer Studies',
//         authors: ['Daguplo', 'Solis']),
//   ];
//   // ignore: non_constant_identifier_names
//   List<Class> class_list = [
//     Class(
//         classID: 123456,
//         image: 'assets/vincent.png',
//         className: "Thesis 1",
//         schedule: "TTH (3:30 - 4:30)",
//         adviser: "Mr. Vincent Patalita",
//         studentID: [123, 123]),
//     Class(
//         classID: 123456,
//         image: 'assets/jovelyn.jpg  ',
//         className: "Research 2",
//         schedule: "Fri (3:30 - 4:30)",
//         adviser: "Ms. Jovelyn Cuizon",
//         studentID: [123, 123, 123, 123, 123, 123, 123]),
//     Class(
//         classID: 123456,
//         image: 'assets/bohol.jpg  ',
//         className: "Thesis 2",
//         schedule: "Fri (3:30 - 4:30)",
//         adviser: "Mr. Cristopher Bohol",
//         studentID: [123, 123, 123, 123, 123, 123, 23]),
//     Class(
//         classID: 123456,
//         image: 'assets/jovelyn.jpg  ',
//         className: "Capstone 1",
//         schedule: "Fri (3:30 - 4:30)",
//         adviser: "Mr. Gregg Gabison",
//         studentID: [123, 123, 123, 123, 123, 123, 123]),
//     Class(
//         classID: 123456,
//         image: 'assets/jovelyn.jpg  ',
//         className: "Capstone 2",
//         schedule: "Sat (3:30 - 4:30)",
//         adviser: "Mr. Fredirick Bandalan",
//         studentID: [123, 123, 123, 123, 123, 123, 123, 123, 123]),
//   ];
//   Future<File?> pickFile() async {
//     final result = await FilePicker.platform.pickFiles(
//         allowMultiple: true,
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'docx']);
//     final file = result?.files.first;

//     if (result == null) return null;
//     // OpenFile.open(file?.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => TeacherLogin()),
//                 );
//               },
//               icon: Icon(Icons.logout))
//         ],
//         title: Text(
//           'Teacher Dashboard',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       drawer: Drawer(
//         child: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               children: <Widget>[
//                 // ListDrawer(),
//               ],
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: Colors.grey.shade100,
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 50,
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 20, right: 20),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search Thesis',
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.greenAccent,
//                   ),
//                   suffixIcon: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.greenAccent,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(
//                       Icons.filter_none,
//                       color: Colors.black,
//                     ),
//                   ),
//                   filled: true,
//                   fillColor: Color(0xfff4f5f9),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(6),
//                     borderSide: BorderSide(color: Color(0xfff4f5f9)),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 20, right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Research List',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Container(
//               height: 500,
//               child: ListView.builder(
//                 itemCount: research.length,
//                 shrinkWrap: true,
//                 physics: BouncingScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 padding: EdgeInsets.only(left: 20, bottom: 20),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.all(5.0),
//                     child: Container(
//                       margin: EdgeInsets.only(right: 24),
//                       padding: EdgeInsets.only(top: 10),
//                       width: 100,
//                       decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 241, 239, 239),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: Colors.greenAccent)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 20.0),
//                               child: ListTile(
//                                 onTap: () {
//                                   // Navigator.push(
//                                   //   context,
//                                   //   MaterialPageRoute(
//                                   //       builder: (context) => ReseachScreen(
//                                   //           name: research[index].title)),
//                                   // );
//                                 },
//                                 // leading: CircleAvatar(
//                                 //   child: Text(
//                                 //     class_list[index].className[0],
//                                 //     style: TextStyle(
//                                 //         fontSize: 20.0,
//                                 //         fontWeight: FontWeight.bold),
//                                 //   ),
//                                 // ),
//                                 contentPadding: EdgeInsets.only(left: 10),
//                                 leading: Image.asset(
//                                   research[index].image,
//                                   height: 80,
//                                   width: 50,
//                                   fit: BoxFit.cover,
//                                 ),

//                                 title: Text(
//                                   research[index].title,
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 subtitle: Text(
//                                     '${research[index].authors[0]}, ${research[index].authors[1]}'),
//                                 selectedColor: Colors.greenAccent,
//                                 trailing: Checkbox(
//                                   value: checkbox,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       print('${research[index].authors[0]}');
//                                       checkbox = value!;
//                                     });
//                                   },
//                                 ), //Che
//                               ),
//                             ),

//                             // Image.asset(
//                             //   categories[index].image,
//                             //   height: 44,
//                             //   width: 44,
//                             //   fit: BoxFit.cover,
//                             // ),
//                             // SizedBox(
//                             //   height: 12,
//                             // ),
//                             // Text(
//                             //   categories[index].title,
//                             //   style: TextStyle(
//                             //       fontSize: 14, fontWeight: FontWeight.w500),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         backgroundColor: Colors.greenAccent,
//         splashColor: Colors.green,
//         onPressed: () {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return Container(
//                   child: AlertDialog(
//                     title: Text(
//                       'Upload File',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 20.0),
//                     ),
//                     content: IconButton(
//                       icon: Icon(
//                         Icons.upload,
//                         size: 50.0,
//                       ),
//                       onPressed: () {
//                         pickFile();
//                       },
//                     ),
//                     actions: [
//                       TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text('CANCEL',
//                               style: TextStyle(
//                                 fontSize: 18.0,
//                               ))),
//                       TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text('CONFIRM',
//                               style: TextStyle(
//                                 fontSize: 18.0,
//                               ))),
//                     ],
//                   ),
//                 );
//               });
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.greenAccent,
//         shape: CircularNotchedRectangle(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.home),
//               iconSize: 30.0,
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.favorite),
//               iconSize: 30.0,
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
