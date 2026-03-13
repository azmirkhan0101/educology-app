import 'dart:io';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ViewDocumentScreen extends StatefulWidget {
  final String url;
  const ViewDocumentScreen({super.key, required this.url});

  @override
  State<ViewDocumentScreen> createState() => _ViewDocumentScreenState();
}

class _ViewDocumentScreenState extends State<ViewDocumentScreen> {
  String? localPath;
  double _progress = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _downloadWithProgress(widget.url);
  }

  Future<void> _downloadWithProgress(String url) async {
    try {
      final request = http.Request('GET', Uri.parse(url));
      final response = await http.Client().send(request);

      // Get the total size of the file from headers
      final contentLength = response.contentLength ?? 0;
      int downloadedLength = 0;
      List<int> bytes = [];

      response.stream.listen(
            (List<int> chunk) {
          setState(() {
            bytes.addAll(chunk);
            downloadedLength += chunk.length;
            // Calculate percentage (0.0 to 1.0)
            _progress = contentLength > 0 ? downloadedLength / contentLength : 0;
          });
        },
        onDone: () async {
          final dir = await getTemporaryDirectory();
          File file = File('${dir.path}/temp_document.pdf');
          await file.writeAsBytes(bytes);

          setState(() {
            localPath = file.path;
            isLoading = false;
          });
        },
        onError: (e) => debugPrint(e.toString()),
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint("Download Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
          title: const Text(
              "View Document",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                  value: _progress,
                backgroundColor: Colors.white,
                color: AppColors.primaryGold,
              ),
              const SizedBox(height: 20),
              Text(
                  "${(_progress * 100).toStringAsFixed(0)}% downloaded",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryGold
                ),
              ),
            ],
          ),
        ),
      )
          : PDFView(filePath: localPath),
    );
  }
}