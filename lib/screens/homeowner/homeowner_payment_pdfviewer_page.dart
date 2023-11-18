import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewer extends StatefulWidget {
  final String path;

  PdfViewer({required this.path});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: widget.path,
      enableSwipe: true,
      swipeHorizontal: true,
    );

  }
}
