import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: const BackButton(),
    elevation: 0,
    backgroundColor: Colors.green,
  );
}
