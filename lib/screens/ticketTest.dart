// // ignore_for_file: unused_field

// import 'package:flutter/material.dart';
// import 'package:thesis_eul/api_service/research_service.dart';
// import 'package:get_it/get_it.dart';
// import 'package:thesis_eul/api_service/api_response.dart';
// import 'package:thesis_eul/models/research_details.dart';
// import 'package:thesis_eul/models/ticket.dart';

// import '../api_service/comments_service.dart';
// import '../models/AccountModel.dart';
// import 'package:dio/dio.dart';

// import '../models/comments.dart';

// class TicketTesting extends StatefulWidget {
//   const TicketTesting({super.key});

//   @override
//   State<TicketTesting> createState() => _TicketTestingState();
// }

// class _TicketTestingState extends State<TicketTesting> {
//   CommentService get comService => GetIt.instance<CommentService>();
//   late APIResponse<bool> _apiResponse;
//   late APIResponse<List<Comments>> _apiComments;

//   Future<APIResponse<bool>> createComment(Comments comment) async {
//     APIResponse<bool> reponse;
//     return reponse = await comService.addComment(comment);
//   }

//   Future<APIResponse<List<Comments>>> getResearchComments(
//       String school_id) async {
//     return _apiComments = await comService.getResearchComments(school_id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Categories'),
//         centerTitle: true,
//         backgroundColor: Colors.red,
//       ),
//       body: FutureBuilder(
//         future: getResearchComments("10006665428378"),
//         builder: (BuildContext context,
//             AsyncSnapshot<APIResponse<List<Comments>>> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final ticket = snapshot.data!;
//           return ListView.builder(
//               itemCount: ticket.data?.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 2,
//                   margin: const EdgeInsets.all(15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: InkWell(
//                     // onTap: () => Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (_) => ProductsByCategoryScreen(
//                     //       categoryName: snapshot.data!.data![index],
//                     //     ),
//                     //   ),
//                     // ),
//                     child: Container(
//                       padding: const EdgeInsets.all(40),
//                       child: Center(
//                         child: Text(
//                           ticket.data?[index].comment_text ?? "shit",
//                           style: const TextStyle(
//                             fontSize: 25,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               });
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // ignore: prefer_const_declarations
//           // final research = const ResearchDetails(
//           //     research_id: "bd093555-ae48-4bc5-b1a8-01293296af35",
//           //     topic_category: ["hello", "were", "are", "you"],
//           //     sdg_category: ["hello", "were", "are", "you"],
//           //     date_published: "2012-07-25",
//           //     adviser: "maam asd",
//           //     department: "Sheeze",
//           //     keywords: ["hello", "were", "are", "you"],
//           //     title: "bohol",
//           //     abstract: "hshsh shshsh sshsh",
//           //     qr: "shshshsh dhhshs",
//           //     number_of_views: 10);
//           // final account = Account(
//           //     school_id: "flutter3",
//           //     first_name: "Cristopher",
//           //     last_name: "Bohol",
//           //     email: "flutter3@gmail.com",
//           //     department: "School of Department",
//           //     password: "wtfffff",
//           //     role: "Student",
//           //     approve: 1);
//           final comments = Comments(
//             school_id: "2020081308",
//             comment_id: 69,
//             authored_id: 53,
//             comment_text: "fuck this shit",
//             created_at: "2020-12-21",
//             updated_at: "2020-12-21",
//           );
//           final result = await getResearchComments("10006665428378");

//           print("ERROR: ${result.errorMessage}");
//           setState(() {
//             // getAllAccount();
//           });
//           // print(result.error);
//         },
//       ),
//     );
//   }
// }
