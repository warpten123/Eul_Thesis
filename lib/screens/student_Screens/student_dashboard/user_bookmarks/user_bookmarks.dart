import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:thesis_eul/screens/utilities/utilities.dart';

import '../../../../api_service/api_response.dart';
import '../../../../api_service/research_service.dart';
import '../user_library/user_view_research.dart';

class UserBookmarks extends StatefulWidget {
  UserBookmarks(this.schoolID, {super.key});
  final String schoolID;

  @override
  State<UserBookmarks> createState() => _UserBookmarksState();
}

class _UserBookmarksState extends State<UserBookmarks> {
  ResearchService get resService => GetIt.instance<ResearchService>();
  bool isSelected = false;
  dynamic _selected = {};
  late APIResponse<List<ResearchDetails>> _apiResponse;
  late List<ResearchDetails> userBookMarks;
  Future<APIResponse<List<ResearchDetails>>> getUserBookmarks(
      String school_id) async {
    return _apiResponse = await resService.getUserBookmarks(school_id);
  }

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
            'My Bookmarks',
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
          ),
        ),
        floatingActionButton: isSelected == true
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            User_View_Research(_selected, widget.schoolID)),
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
              future: getUserBookmarks(widget.schoolID),
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
