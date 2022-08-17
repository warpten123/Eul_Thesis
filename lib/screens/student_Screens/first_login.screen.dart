import 'package:flutter/material.dart';
import 'package:thesis_eul/screens/code_screen.dart';
import 'package:thesis_eul/screens/user_dashboard.dart';

class FirstLoginScreen extends StatelessWidget {
  const FirstLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/usjr3.jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xff161d27).withOpacity(0.9),
                  Color(0xff161d27),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Welcome Josenian!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'To get started, pick topics that you like',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // implement GridView.builder
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: 8,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Card(
                              child: GridTile(
                                header: Image.asset('assets/pj.jpg'),
                                child: Text('1'),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
