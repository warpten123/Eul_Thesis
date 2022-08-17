import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReseachScreen extends StatelessWidget {
  final String name;
  const ReseachScreen({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.document_scanner_outlined))
          ],
        ),
      ),
    );
  }
}
