import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/api_service/comments_service.dart';
import 'package:thesis_eul/api_service/research_service.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/user_library/comments_view_research.dart';
import '../../../../api_service/api_response.dart';
import '../../../../models/comments.dart';

class TempButton extends StatefulWidget {
  String researchID;
  TempButton(this.researchID, {super.key});

  @override
  State<TempButton> createState() => _TempButtonState();
}

class _TempButtonState extends State<TempButton> {
  CommentService get comService => GetIt.instance<CommentService>();
  ResearchService get resService => GetIt.instance<ResearchService>();
  late APIResponse<List<Comments>> _apiResponse;
  bool isGo = false;
  late Comments checker;
  Future<APIResponse<List<Comments>>> getCommentsByID(String resID) async {
    return _apiResponse = await comService.getResearchCommentsByID(resID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30, top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
          final result = await getCommentsByID(widget.researchID);
          checker = result.data![0];
          if (checker.authored_id == null) {
            isGo = false;
          } else {
            isGo = true;
          }
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommentsView(widget.researchID, isGo)),
          );
        },
        child: Container(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(vertical: 16),
          // ignore: prefer_const_constructors
          child: Text(
            'Read Comments',
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
