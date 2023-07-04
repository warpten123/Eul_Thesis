import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/api_service/research_service.dart';
import 'package:thesis_eul/models/research.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/research_list/research_details.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/user_library/user_view_research.dart';

import '../../../../api_service/api_response.dart';
import '../../../../models/AccountModel.dart';

class UserLibrary extends StatefulWidget {
  UserLibrary(this.account, {super.key});
  Account account;

  @override
  State<UserLibrary> createState() => _UserLibraryState();
}

class _UserLibraryState extends State<UserLibrary> {
  ResearchService get resService => GetIt.instance<ResearchService>();
  late APIResponse<List<ResearchDetails>> _apiResponseRes;

  Future<APIResponse<List<ResearchDetails>>> getUserLibrary(
      String schoolID) async {
    return _apiResponseRes = await resService.getUserLibray(schoolID);
  }

  // @override
  // void initState() {
  //   getResearchUser();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // void getResearchUser() async {
  //   final result = await getUserLibrary(widget.schoolID);
  //   research = result.data!;
  // }

  late List<ResearchDetails> research;

  bool isSelected = false;
  dynamic _selected = {};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          // ignore: prefer_const_constructors
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            'My Papers',
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
          ),
        ),
        floatingActionButton: isSelected == true
            ? FloatingActionButton(
                onPressed: () {
                  print("selected ${_selected}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            User_View_Research(_selected, widget.account)),
                  );
                },
                child: const Icon(Icons.arrow_forward_ios),
              )
            : null,
        // ignore: sized_box_for_whitespace
        body: Stack(
          children: [
            Container(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/newback.jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.transparent,
                  const Color(0xff161d27).withOpacity(0.9),
                  const Color(0xff161d27),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            FutureBuilder(
              future: getUserLibrary(widget.account.account_id!),
              builder: (BuildContext context,
                  AsyncSnapshot<APIResponse<List<ResearchDetails>>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final research = snapshot.data!;
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CarouselSlider(
                      options: CarouselOptions(
                        height: 450,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.70,
                        enlargeCenterPage: true,
                      ),
                      items: research.data!.map((res) {
                        return Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_selected == res) {
                                  _selected = {};
                                  isSelected = false;
                                } else {
                                  isSelected = true;
                                  _selected = res;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: _selected == res
                                    ? Border.all(
                                        color: Colors.blue.shade500, width: 3)
                                    : null,
                                boxShadow: _selected == res
                                    ? [
                                        BoxShadow(
                                            color: Colors.blue.shade100,
                                            blurRadius: 30,
                                            offset: const Offset(0, 10)),
                                      ]
                                    : [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 20,
                                            offset: const Offset(0, 5)),
                                      ],
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: 320,
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Image.asset(
                                            'assets/cover_page.jpg',
                                            fit: BoxFit.cover)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(res.title,
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text("Published: ${res.date_published}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600)),
                                    Text(
                                        "Research #${research.data!.indexOf(res) + 1}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.grey.shade600)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      }).toList()),
                );
              },
            ),
          ],
        ),
        //
        //
      ),
    );
  }
}
