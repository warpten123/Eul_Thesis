import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thesis_eul/api_service/file_service.dart';
import 'package:thesis_eul/models/research_details.dart';

import '../../../../api_service/api_response.dart';
import '../../../../api_service/research_service.dart';
import '../../../../models/AccountModel.dart';
import '../../../utilities/utilities.dart';

class User_View_Research extends StatefulWidget {
  User_View_Research(this.research, this.id, {super.key});
  ResearchDetails research;
  String id;

  @override
  State<User_View_Research> createState() => _User_View_ResearchState();
}

class _User_View_ResearchState extends State<User_View_Research> {
  bool isFavorite = false;
  ResearchService get resService => GetIt.instance<ResearchService>();
  FileService get fileService => GetIt.instance<FileService>();
  late APIResponse<dynamic> _apiResponseRes;
  Future<APIResponse<Uint8List>> getResearchFile(String schoolID) async {
    return _apiResponseRes = await fileService.getResearchFile(schoolID);
  }

  Future<APIResponse<bool>> addResearchList(
      String research_id, String student_id) async {
    // ignore: unused_local_variable
    APIResponse<bool> reponse;
    return reponse = await resService.addResearchList(research_id, student_id);
  }

  Future<APIResponse<bool>> removeBookMark(
      String research_id, String student_id) async {
    // ignore: unused_local_variable
    APIResponse<bool> reponse;
    return reponse = await resService.removeBookmark(research_id, student_id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.research.title),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ResHeader(),
              ResName(),
              ResDesc(),
              ViewPDF(),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ResHeader() {
    return Container(
      height: 350,
      width: double.infinity,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
          // ignore: prefer_const_constructors
          image: DecorationImage(
        // ignore: prefer_const_constructors
        image: NetworkImage(
            "https://drive.google.com/uc?export=view&id=1Woq9Rbqasw6Ek98lP4fPIIRWCy0WJy9k"),
        fit: BoxFit.cover,
      )),
      child: Stack(
        children: [
          Positioned(
              left: 10,
              top: MediaQuery.of(context).padding.top,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  // ignore: prefer_const_constructors
                  child: Icon(Icons.arrow_back),
                ),
              )),
          Positioned(
            right: 5,
            bottom: 5,
            child: SizedBox(
                height: 100,
                // padding: EdgeInsets.all(8),
                // decoration: BoxDecoration(
                //     color: Colors.white, borderRadius: BorderRadius.circular(36)),
                child: IconButton(
                  isSelected: isFavorite,
                  color: Colors.red,
                  iconSize: 50.0,
                  icon: isFavorite == false
                      ? const Icon(Icons.favorite_border_outlined)
                      : const Icon(Icons.favorite),
                  onPressed: () async {
                    setState(() {
                      if (isFavorite == false) {
                        isFavorite = true;
                        addBookMarks();
                        showSnackBarSucess(context, "Research Bookmarked!");
                      } else {
                        isFavorite = false;
                        showSnackBarError(context, "Removed from Bookmarks!");
                      }
                    });
                  },
                )),
          ),
        ],
      ),
    );
  }

  void addBookMarks() async {
    final resultList =
        await addResearchList(widget.research.research_id!, widget.id);
  }

  void removeBookMarks() async {
    final result =
        await removeBookMark(widget.research.research_id!, widget.id);
  }

  // ignore: non_constant_identifier_names
  Widget ResName() {
    return Container(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
      // ignore: prefer_const_constructors

      decoration: const BoxDecoration(
        color: Colors.grey,
        // ignore: unnecessary_const
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          // ignore: unnecessary_const
          bottomRight: const Radius.circular(36),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text(
                  widget.research.title,
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // ignore: prefer_const_constructors
                Text(
                  "Adviser: ${widget.research.adviser}",
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Row(
            // ignore: prefer_const_constructors
            children: [
              const Icon(Icons.remove_red_eye),
              Text(
                widget.research.number_of_views.toString(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ResDesc() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            'Goals',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.research.sdg_category.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        "${widget.research.sdg_category[index]}, ",
                        style: const TextStyle(fontSize: 25.0),
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
              ),
            ],
          ),
          const Text(
            'Abstract',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.research.abstracts,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Date Approved',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.research.date_published,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 18, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget ViewPDF() {
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
          print("BOOK ${widget.research.research_id}");
          // ignore: use_build_context_synchronously
          final result = await getResearchFile(widget.research.research_id!);
          if (result.data == null) {
            // ignore: use_build_context_synchronously
            showSnackBarError(context, "Paper not found!");
          } else {
            var file = await writeToFile(result.data!);
            // ignore: use_build_context_synchronously
            openPDF(context, file.path);
          }
        },
        child: Container(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(vertical: 16),
          // ignore: prefer_const_constructors
          child: Text(
            'Read Paper',
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Future<File> writeToFile(Uint8List data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/file.pdf';
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
