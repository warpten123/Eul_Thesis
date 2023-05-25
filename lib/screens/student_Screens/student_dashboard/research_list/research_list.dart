import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:thesis_eul/api_service/api_response.dart';
import 'package:thesis_eul/api_service/research_service.dart';
import 'package:thesis_eul/api_service/user_service.dart';
import 'package:thesis_eul/models/AccountModel.dart';
import 'package:thesis_eul/models/res_categories.dart';

import 'package:thesis_eul/models/research_details.dart';

import 'package:thesis_eul/models/sdg.dart';

import 'package:thesis_eul/screens/student_Screens/student_dashboard/user_library/user_view_research.dart';

import '../../../utilities/utilities.dart';
import '../search_screen.dart';

// ignore: must_be_immutable
class ContentUserDashBoard extends StatefulWidget {
  SDG sdg;
  String id;
  ContentUserDashBoard(this.sdg, this.id, {super.key});
  @override
  State<ContentUserDashBoard> createState() => _ContentUserDashBoardState();
}

class _ContentUserDashBoardState extends State<ContentUserDashBoard> {
  bool checkbox = false;

  List<Categories> categories = [
    Categories(title: 'All', image: 'assets/vision.jpg', count: 4),
    Categories(
        title: 'Artificial Intelligence', image: 'assets/ai.png', count: 2),
    Categories(title: 'Machine Learning', image: 'assets/ml.png', count: 2),
    Categories(title: 'Computer Vision', image: 'assets/vision.jpg', count: 4),
  ];
  ResearchService get resService => GetIt.instance<ResearchService>();
  UserService get userService => GetIt.instance<UserService>();
  late APIResponse<List<Account>> _apiResponse;
  late APIResponse<List<ResearchDetails>> _apiResponseRes;
  late Account finalAccount;
  Future<APIResponse<List<Account>>> getAllAccount() async {
    return _apiResponse = await userService.getAllAccounts();
  }

  Future<APIResponse<List<ResearchDetails>>> getAllResearch() async {
    return _apiResponseRes = await resService.getResearchList(1);
  }

  Future<APIResponse<bool>> createAccount(Account account) async {
    APIResponse<bool> reponse;
    return reponse = await userService.createAccount(account);
  }

  Future<APIResponse<List<ResearchDetails>>> getSDG() async {
    return _apiResponseRes = await resService.getSDGList(widget.sdg.goal);
    // final _apiResponseRes = await resService.getResearchList();
    // for (int i = 0; i < _apiResponseRes.data!.length; i++) {
    //   test[i] = "";
    // }
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx']);
    final file = result?.files.first;

    if (result == null) return null;
    // OpenFile.open(file?.path);
  }

  @override
  void initState() {
    super.initState();
    getAccounts();
  }

  late APIResponse<Account> _getAccount;
  Future<APIResponse<Account>> getAccount(String school_id) async {
    return _getAccount = await userService.getStudentByID(school_id);
  }

  void getAccounts() async {
    try {
      print("FUCK");
      final result = await getAccount(widget.id);
      finalAccount = result.data!;
      print("Mounted $mounted");
      if (mounted) {
        setState(() {});
      }
      // ignore: empty_catches
    } catch (e) {
      showSnackBarError(context, "Error Getting User Information!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       icon: Icon(Icons.logout))
        // ],
        title: Text(
          '${widget.sdg.goal} ${widget.sdg.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.amberAccent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.search),
                        width: 24,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search Thesis...'),
                ),
              ),
              // child: TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Search Thesis...',
              //     // ignore: prefer_const_constructors
              //     prefixIcon: Icon(
              //       Icons.search,
              //       color: Colors.greenAccent,
              //     ),
              //     suffixIcon: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.greenAccent,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       child: const Icon(
              //         Icons.filter_none,
              //         color: Colors.black,
              //       ),
              //     ),
              //     filled: true,
              //     fillColor: const Color(0xfff4f5f9),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(6),
              //       borderSide: const BorderSide(color: Color(0xfff4f5f9)),
              //     ),
              //   ),
              // ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Select Category',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 50,
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 24),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Image.asset(
                        //   categories[index].image,
                        //   height: 44,
                        //   width: 44,
                        //   fit: BoxFit.cover,
                        // ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          categories[index].title,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  const Text(
                    'Tap a research!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Pick one...',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 400,
              child: FutureBuilder(
                  future: getSDG(),
                  builder: (BuildContext context,
                      AsyncSnapshot<APIResponse<List<ResearchDetails>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final research = snapshot.data!;
                    return ListView.builder(
                      itemCount: research.data?.length ?? 0,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            margin: const EdgeInsets.only(right: 24),
                            padding: const EdgeInsets.only(top: 10),
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 241, 239, 239),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.greenAccent)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  User_View_Research(
                                                      research.data![index],
                                                      finalAccount)),
                                        );
                                      },
                                      leading: Image.asset(
                                        "assets/cover_page.jpg",
                                        height: 80,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.only(left: 10),
                                      title: Text(
                                        research.data![index].title,
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          '${research.data![index].sdg_category}, ${research.data![index].title}'),
                                      selectedColor: Colors.greenAccent,
                                      trailing: Checkbox(
                                        value: checkbox,
                                        onChanged: (value) {
                                          // setState(() {
                                          //   print(
                                          //       '${research[index].authors[0]}');
                                          //   checkbox = value!;
                                          // });
                                        },
                                      ), //Che
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
