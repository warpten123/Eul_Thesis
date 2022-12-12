// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:thesis_eul/models/sdg.dart';
// import 'package:thesis_eul/screens/student_Screens/student_dashboard/sdg_details/sdg_details.dart';

// class PlaceItem extends StatelessWidget {
//   final SDG sdg;
//   // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
//   PlaceItem(this.sdg);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => SDGDetails(sdg)),
//         );
//       },
//       child: Stack(
//         children: [
//           Container(
//             alignment: Alignment.bottomLeft,
//             height: 200,
//             width: 200,
//             // ignore: prefer_const_constructors
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               image: DecorationImage(
//                 image: AssetImage(sdg.image),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: <Widget>[
//                   // ignore: prefer_const_constructors
//                   // Text(
//                   //   sdg.goal,
//                   //   style: TextStyle(
//                   //     color: Colors.white,
//                   //     fontSize: 20,
//                   //     fontWeight: FontWeight.bold,
//                   //   ),
//                   // ),
//                   // Text(
//                   //   sdg.name,
//                   //   style: TextStyle(
//                   //     color: Colors.white,
//                   //     fontSize: 15,
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
