import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:thesis_eul/models/res_categories.dart';
import 'package:thesis_eul/models/research.dart';

import 'header_drawer.dart';

class ContentUserDashBoard extends StatefulWidget {
  ContentUserDashBoard({Key? key}) : super(key: key);

  @override
  State<ContentUserDashBoard> createState() => _ContentUserDashBoardState();
}

class _ContentUserDashBoardState extends State<ContentUserDashBoard> {
  bool checkbox = false;

  List<Categories> categories = [
    Categories(
        title: 'Artificial Intelligence', image: 'assets/ai.png', count: 2),
    Categories(title: 'Machine Learning', image: 'assets/ml.png', count: 2),
    Categories(title: 'Computer Vision', image: 'assets/vision.jpg', count: 4),
  ];

  List<Research> research = [
    Research(
        title: 'Eul: An Intelligent Research Repository Management',
        image: 'assets/cover_page.jpg',
        department: 'School Of Computer Studies',
        authors: ['Bohol', 'Premacio']),
    Research(
        title: 'A Research Title',
        image: 'assets/cover_page.jpg',
        department: 'School Of Computer Studies',
        authors: ['Cuizon', 'Gadiane']),
    Research(
        title: 'Another Research Title',
        image: 'assets/cover_page.jpg',
        department: 'School Of Computer Studies',
        authors: ['Patalita', 'Bandalan']),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                HeaderDrawer(),
                // ListDrawer(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SizedBox(
            //   height: 60,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 20, right: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Icon(
            //         Icons.menu,
            //         size: 36,
            //       ),
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(30),
            //         child: Image.asset(
            //           'assets/pj.jpg',
            //           height: 36,
            //           width: 36,
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Welcome Josenian!',
                style: TextStyle(
                    fontSize: 40, height: 1.2, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Thesis...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.greenAccent,
                  ),
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.filter_none,
                      color: Colors.black,
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xfff4f5f9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Color(0xfff4f5f9)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Select Category',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 110,
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 20),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 24),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          categories[index].image,
                          height: 44,
                          width: 44,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          categories[index].title,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Tap a research!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Pick one...',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: research.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(left: 20, bottom: 20),
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
                          border: Border.all(color: Colors.greenAccent)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: ListTile(
                                leading: Image.asset(
                                  research[index].image,
                                  height: 80,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                                contentPadding: EdgeInsets.only(left: 10),
                                title: Text(
                                  research[index].title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    '${research[index].authors[0]}, ${research[index].authors[1]}'),
                                selectedColor: Colors.greenAccent,
                                trailing: Checkbox(
                                  value: checkbox,
                                  onChanged: (value) {
                                    setState(() {
                                      print('${research[index].authors[0]}');
                                      checkbox = value!;
                                    });
                                  },
                                ), //Che
                              ),
                            ),

                            // Image.asset(
                            //   categories[index].image,
                            //   height: 44,
                            //   width: 44,
                            //   fit: BoxFit.cover,
                            // ),
                            // SizedBox(
                            //   height: 12,
                            // ),
                            // Text(
                            //   categories[index].title,
                            //   style: TextStyle(
                            //       fontSize: 14, fontWeight: FontWeight.w500),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
