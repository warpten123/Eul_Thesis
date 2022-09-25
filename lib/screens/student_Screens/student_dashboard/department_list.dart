import 'package:flutter/material.dart';

class Department_List extends StatefulWidget {
  @override
  State<Department_List> createState() => _Department_ListState();
}

class _Department_ListState extends State<Department_List> {
  final department_list = [
    'All',
    'Latest',
    'Oldest',
    'Department',
    'Faculty Research',
    'Undergrad Research',
    'Postgrad Research',
  ];
  int current_selected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 20,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    current_selected = index;
                  });
                },
                child: Text(
                  department_list[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: current_selected == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: current_selected == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ),
              )),
          separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
          itemCount: department_list.length),
    );
  }
}
