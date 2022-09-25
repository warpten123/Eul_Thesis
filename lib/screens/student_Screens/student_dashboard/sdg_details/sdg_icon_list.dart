import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SDGIconList extends StatefulWidget {
  @override
  State<SDGIconList> createState() => _SDGIconListState();
}

class _SDGIconListState extends State<SDGIconList> {
  List<IconData> icons = [Icons.link, Icons.favorite];
  int currentSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              currentSelect = index;
            });
          },
          child: Container(
              width: 60,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: currentSelect == index ? Colors.green : Colors.white10,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  currentSelect == index
                      ? BoxShadow()
                      : BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3)),
                ],
              ),
              child: IconButton(
                icon: Icon(icons[index]),
                onPressed: () {},
              )),
        ),
        separatorBuilder: ((context, index) => SizedBox(
              width: 20,
            )),
        itemCount: icons.length,
      ),
    );
  }
}
