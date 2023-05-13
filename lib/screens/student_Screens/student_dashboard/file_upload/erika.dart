// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/questions_model.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:study_up_app/main_screens/group/quiz/create_quiz.dart';
// import 'package:study_up_app/main_screens/group/quiz/quiz.dart';
// import 'package:study_up_app/services/database.dart';

// import 'erika_new.dart';

// class Erika extends StatefulWidget {
//   const Erika({super.key});

//   @override
//   State<Erika> createState() => _ErikaState();
// }

// class _ErikaState extends State<Erika> {
//   List<Widget> shit = [];
//   List<QuestionModel> questionModel = [];
//   int counter = 0;
//   void addItem() {
//     setState(() {
//       final payload = QuestionModel(
//           question: " ",
//           option1: " ",
//           option2: " ",
//           option3: " ",
//           option4: " ");
//       questionModel.add(payload);
//       shit.add(erika(counter));
//       counter += 1;
//     });
//   }

//   Widget erika(int index) {
//     final txtController = TextEditingController();
//     String onchangeval = "";
//     return Center(
//       child: Column(
//         children: [
//           Text("Add Some Shit"),
//           TextFormField(
//             onChanged: (value) {
//               setState(() {
//                 onchangeval = value;
//               });
//               questionModel[index].question = onchangeval;
//             },
//             controller: txtController,
//             decoration: const InputDecoration(labelText: 'Question'),
//           ),
//           TextFormField(
//             onChanged: (value) {
//               setState(() {
//                 onchangeval = value;
//               });
//               questionModel[index].option1 = onchangeval;
//             },
//             decoration: const InputDecoration(labelText: 'Option 1'),
//           ),
//           TextFormField(
//             onChanged: (value) {
//               setState(() {
//                 onchangeval = value;
//               });
//               questionModel[index].option2 = onchangeval;
//             },
//             decoration: const InputDecoration(labelText: 'Option 2'),
//           ),
//           TextFormField(
//             onChanged: (value) {
//               setState(() {
//                 onchangeval = value;
//               });
//               questionModel[index].option3 = onchangeval;
//             },
//             decoration: const InputDecoration(labelText: 'Option 3'),
//           ),
//           TextFormField(
//             onChanged: (value) {
//               setState(() {
//                 onchangeval = value;
//               });
//               questionModel[index].option4 = onchangeval;
//             },
//             decoration: const InputDecoration(labelText: 'Option 4'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton:
//           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         FloatingActionButton.extended(
//           onPressed: addItem,
//           label: Text('Add Question'),
//           heroTag: null,
//         ),
//         FloatingActionButton.extended(
//           onPressed: () async {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Kisha(questionModel)),
//             );
//           },
//           label: Text('Submit'),
//         ),
//       ]),
//       body: ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: shit.length,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               shit[index],
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Future<void> addQuestionData(
//       String quizId, Map<String, dynamic> questionData) async {
//     await FirebaseFirestore.instance
//         .collection("Quiz")
//         .doc(quizId)
//         .collection('QNA')
//         .add(questionData)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   bool _isLoading = false;

//   uploadQuestionData() async {
//     // if (_formKey.currentState!.validate()) {
//     setState(() {
//       _isLoading = true;
//     });

//     for (int i = 0; i < questionModel.length; i++) {
//       Map<String, String> questionMap = {
//         'question': questionModel[i].question,
//         'option1': questionModel[i].option1,
//         'option2': questionModel[i].option2,
//         'option3': questionModel[i].option3,
//         'option4': questionModel[i].option4,
//       };
//       await addQuestionData(widget.quizId, questionMap).then((value) {
//         setState(() {
//           _isLoading = false;
//         });
//       });   
//     }
//   }
// }
