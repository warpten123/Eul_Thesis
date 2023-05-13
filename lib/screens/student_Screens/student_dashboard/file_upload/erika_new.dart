// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/questions_model.dart';

// class Kisha extends StatefulWidget {
//   Kisha(this.shit, {super.key});
//   List<QuestionModel> shit;

//   @override
//   State<Kisha> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<Kisha> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: widget.shit.length,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               Text(widget.shit[index].question),
//               Text(widget.shit[index].option1),
//               Text(widget.shit[index].option2),
//               Text(widget.shit[index].option3),
//               Text(widget.shit[index].option4),
//               SizedBox(
//                 height: 100,
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
