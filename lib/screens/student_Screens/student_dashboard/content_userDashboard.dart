// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:thesis_eul/models/res_categories.dart';
// import 'package:thesis_eul/models/research.dart';
// import 'package:thesis_eul/screens/student_Screens/header_drawer.dart';
// import 'package:thesis_eul/screens/student_Screens/research_screen.dart';
// import 'package:thesis_eul/screens/student_Screens/student_dashboard/department_list.dart';
// import 'package:thesis_eul/screens/student_Screens/student_dashboard/research_list/research_details.dart';

// import '../../../models/research_details.dart';
// import '../../../models/sdg.dart';

// class ContentUserDashBoard extends StatefulWidget {
//   SDG sdg;
//   ContentUserDashBoard(this.sdg);
//   @override
//   State<ContentUserDashBoard> createState() => _ContentUserDashBoardState();
// }

// class _ContentUserDashBoardState extends State<ContentUserDashBoard> {
//   bool checkbox = false;

//   List<Categories> categories = [
//     Categories(title: 'All', image: 'assets/vision.jpg', count: 4),
//     Categories(
//         title: 'Artificial Intelligence', image: 'assets/ai.png', count: 2),
//     Categories(title: 'Machine Learning', image: 'assets/ml.png', count: 2),
//     Categories(title: 'Computer Vision', image: 'assets/vision.jpg', count: 4),
//   ];

//   List<ResearchDetails> research = [
//     ResearchDetails(
//       title: 'Eul: An Intelligent Research Repository Management',
//       image: 'assets/cover_page.jpg',
//       department: 'School Of Computer Studies',
//       authors: ['Bohol', 'Premacio'],
//       adviser: 'Mrs. Lorna Miro',
//     ),
//     ResearchDetails(
//       title: 'A Research Title',
//       image: 'assets/cover_page.jpg',
//       department: 'School Of Computer Studies',
//       authors: ['Cuizon', 'Gadiane'],
//       adviser: 'Mrs. Lorna Miro',
//     ),
//     ResearchDetails(
//       title: 'Another Research Title',
//       image: 'assets/cover_page.jpg',
//       department: 'School Of Computer Studies',
//       authors: ['Patalita', 'Bandalan'],
//       adviser: 'Mrs. Lorna Miro',
//     ),
//     ResearchDetails(
//       title: 'StudyUp',
//       image: 'assets/cover_page.jpg',
//       department: 'School Of Computer Studies',
//       authors: ['Daguplo', 'Solis'],
//       adviser: 'Mrs. Lorna Miro',
//     ),
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
//       // drawer: NavigationDrawer(),
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         actions: [],
//         title: Text(
//           "${widget.sdg.goal}: ${widget.sdg.name}",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
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
//             // SizedBox(
//             //   height: 30,
//             // ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20, bottom: 10),
//               child: Text(
//                 'Select Research to Read...',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 20, right: 20),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.greenAccent,
//                   ),
//                   // suffixIcon: Container(
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.greenAccent,
//                   //     borderRadius: BorderRadius.circular(8),
//                   //   ),
//                   //   child: Icon(
//                   //     Icons.filter_none,
//                   //     color: Colors.black,
//                   //   ),
//                   // ),
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
//             Department_List(),
//             SizedBox(
//               height: 30,
//             ),
//             Container(
//               height: 600,
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
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Research_Details(
//                                             widget.sdg, research[index])),
//                                   );
//                                 },
//                                 leading: Image.asset(
//                                   research[index].image,
//                                   height: 80,
//                                   width: 50,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 contentPadding: EdgeInsets.only(left: 10),
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
//     ));
//   }
// }
