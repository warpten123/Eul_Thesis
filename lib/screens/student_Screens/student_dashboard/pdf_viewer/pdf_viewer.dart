import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class PDFViewerWidget extends StatefulWidget {
  final File file;
  const PDFViewerWidget(this.file, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewerWidget> {
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: PDFView(
        filePath: widget.file.path,
        nightMode: false,
      ),
    );
  }
}
