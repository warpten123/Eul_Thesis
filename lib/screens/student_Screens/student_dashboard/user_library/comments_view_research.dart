import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/api_service/comments_service.dart';
import 'package:thesis_eul/api_service/research_service.dart';
import 'package:thesis_eul/models/authored.dart';
import 'package:thesis_eul/screens/utilities/utilities.dart';

import '../../../../api_service/api_response.dart';
import '../../../../models/AccountModel.dart';
import '../../../../models/comments.dart';

class CommentsView extends StatefulWidget {
  final String researchID;
  final bool isComment;
  const CommentsView(this.researchID, this.isComment, {super.key});
  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  CommentService get comService => GetIt.instance<CommentService>();
  ResearchService get resService => GetIt.instance<ResearchService>();
  late APIResponse<List<Comments>> _apiResponse;
  late APIResponse<bool> _apiResponseComment;
  late APIResponse<Authored> _apiResponseAuthored;
  final commentText = TextEditingController();
  late Authored authored;
  late bool go;
  Future<APIResponse<List<Comments>>> getCommentsByID(String resID) async {
    return _apiResponse = await comService.getResearchCommentsByID(resID);
  }

  Future<APIResponse<bool>> createComment(Comments comment) async {
    return _apiResponseComment = await comService.addComment(comment);
  }

  Future<APIResponse<Authored>> getAuthored(String researchID) async {
    return _apiResponseAuthored = await resService.getAuthored(researchID);
  }

  Future<void> showModalText(BuildContext context) {
    return showModalBottomSheet<void>(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            TextFormField(
              controller: commentText,
            ),
            TextButton(
                onPressed: () async {
                  int commentID = generateCommentID();
                  final result = await getAuthored(widget.researchID);
                  if (result.data == null) {
                    // ignore: use_build_context_synchronously
                    showSnackBarError(context, "Error Retrieving Data");
                  } else {
                    authored = result.data!;
                    final payload = Comments(
                      comment_id: commentID,
                      comment_text: commentText.text,
                      created_at: DateTime.now().toString(),
                      updated_at: DateTime.now().toString(),
                      authored_id: authored.authored_id!,
                      school_id: authored.school_id,
                    );
                    final resultComment = await createComment(payload);
                    if (resultComment.data != null) {
                      // ignore: use_build_context_synchronously
                      showSnackBarSucess(context, "Comment Added Sucessfully!");
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } else {
                      // ignore: use_build_context_synchronously
                      showSnackBarError(context, "Error Adding Comment!");
                    }
                    setState(() {
                      getCommentsByID(widget.researchID);
                    });
                  }
                },
                child: const Text("Add Comment")),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print("Go ${widget.isComment}");
    go = widget.isComment;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalText(context);
          },
        ),
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              go
                  ? FutureBuilder(
                      future: getCommentsByID(widget.researchID),
                      builder: (BuildContext context,
                          AsyncSnapshot<APIResponse<List<Comments>>> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final comments = snapshot.data!;
                        return ListView.builder(
                          itemCount: comments.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(left: 20, bottom: 20),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Container(
                                margin: EdgeInsets.only(right: 24),
                                padding: EdgeInsets.only(top: 10),
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 241, 239, 239),
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: Colors.greenAccent)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: ListTile(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           User_View_Research(
                                            //               research.data![index],
                                            //               widget.id)),
                                            // );
                                          },
                                          leading: Image.asset(
                                            "assets/cover_page.jpg",
                                            height: 80,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 10),
                                          title: Text(
                                            comments.data![index].comment_text,
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                              '${comments.data![index].updated_at}, ${comments.data![index].created_at}'),
                                          selectedColor: Colors.greenAccent,
                                          // trailing: Checkbox(
                                          //   value: checkbox,
                                          //   onChanged: (value) {
                                          //     // setState(() {
                                          //     //   print(
                                          //     //       '${research[index].authors[0]}');
                                          //     //   checkbox = value!;
                                          //     // });
                                          //   },
                                          // ), //Che
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      })
                  : Text("No Comments Yet!"),
            ],
          ),
        ),
      ),
    );
  }
}
