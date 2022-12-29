import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FUCK extends StatelessWidget {
  const FUCK(this.bytes, {super.key});
  final Uint8List bytes;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade800,
      // ignore: prefer_const_constructors
      backgroundImage: MemoryImage(bytes),
    );
  }
}
