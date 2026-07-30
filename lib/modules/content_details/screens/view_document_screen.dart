import 'dart:io';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/modules/teacher/controllers/report_exporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nextgen_pdf_editor/nextgen_pdf_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:nextgen_pdf_editor/nextgen_pdf_editor.dart'; // Imported editor package

import '../../../core/utils/extensions.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../routes/app_pages.dart';

class ViewDocumentScreen extends StatefulWidget {
  final String url;
  final String? title;
  final bool showEditIcon;
  final String? submissionId;
  final int? index;
  const ViewDocumentScreen({super.key, required this.url, this.title, this.showEditIcon = false, this.submissionId, this.index});

  @override
  State<ViewDocumentScreen> createState() => _ViewDocumentScreenState();
}

class _ViewDocumentScreenState extends State<ViewDocumentScreen> {
  String? localPath;
  double _progress = 0;
  bool isLoading = true;
  File? correctedAnswer;

  @override
  void initState() {
    super.initState();

    _downloadWithProgress(widget.url);
  }

  Future<void> _downloadWithProgress(String url) async {
    try {
      final request = http.Request('GET', Uri.parse(url));
      final response = await http.Client().send(request);

      final contentLength = response.contentLength ?? 0;
      int downloadedLength = 0;
      List<int> bytes = [];

      response.stream.listen(
            (List<int> chunk) {
          setState(() {
            bytes.addAll(chunk);
            downloadedLength += chunk.length;
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
        onError: (e) {
          debugPrint(e.toString());
          setState(() => isLoading = false);
        },
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint("Download Error: $e");
      setState(() => isLoading = false);
    }
  }

  // Action method to open the editor
  Future<void> _editPDF() async {
    if (localPath == null) return;

    try {
      final File originalFile = File(localPath!);

      // Opens the Editor View overlay on the PDF
      final File? editedFile = await NGPdf.openEditor(context, originalFile);

      if (editedFile != null) {
        correctedAnswer = editedFile;
        setState(() {
          // Update the local path with the newly saved PDF
          localPath = editedFile.path;
        });
        showSnackBar(
          title: "Saved",
          message: "PDF edited and saved successfully!",
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      debugPrint("Editing Error: $e");
      showSnackBar(
        title: "Error",
        message: "Failed to open editor: $e",
        backgroundColor: AppColors.errorRed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          widget.title ?? "View Document",
          style: TextStyle( fontSize: isTab ? 12.sp : null, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: Colors.black87, size: isTab ? 30 : null,)),
        centerTitle: true,
        actions: [
          // Show the edit button only after the file has finished downloading [4.1.4]
          if ( widget.showEditIcon && !isLoading && localPath != null)
            IconButton(
              onPressed: _editPDF,
              icon: Icon(Icons.edit, color: AppColors.primaryGold, size: isTab ? 30 : null,),
              tooltip: "Edit PDF",
            ),
          IconButton(
            onPressed: () async{
              //openLinkInBrowser(classLink: widget.url);
              ReportExporter exporter = ReportExporter();
              File savedFile = File(localPath!);
              final bytes = await savedFile.readAsBytes();
              await exporter.saveFile( bytes, "educology_exported.pdf", isBytes: true);
            },
            icon: Icon(Icons.download, size: isTab ? 30 : null,),
            tooltip: "Download original",
          ),
        ],
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
                  fontSize: isTab ? 12.sp : 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryGold,
                ),
              ),
            ],
          ),
        ),
      )
          : Column(
            children: [
              Expanded(
                child: PDFView(
                        // Using ValueKey(localPath) forces the PDFView widget to dispose and
                        // completely reload the newly updated file path after changes are saved.
                        key: ValueKey(localPath),
                        filePath: localPath,
                      ),
              ),
              if( widget.showEditIcon && correctedAnswer != null )...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: ButtonWidget(
                    label: "Provide Mark",
                    buttonHeight: 40.h,
                    buttonWidth: isTab ? context.fullWidth * 0.3 : null,
                    onPressed: (){
                      Get.offAndToNamed(
                          AppRoutes.provideMark,
                          arguments: {
                            "submissionId" : widget.submissionId,
                            "index": widget.index,
                            "correctedAnswer": correctedAnswer
                          }
                      );
                    },
                  ),
                ),
                const SizedBox( height: 30,)
              ]
            ],
          ),
    );
  }

  // OPEN CLASS LINK IN BROWSER
  Future<void> openLinkInBrowser({required String classLink}) async {
    final Uri? url = Uri.tryParse(classLink);

    if (url == null || !url.hasScheme) {
      showSnackBar(
        title: "Cannot open",
        message: "Invalid URL format",
        backgroundColor: AppColors.errorRed,
      );
      return;
    }

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        showSnackBar(
          title: "Failed",
          message: "No application found to handle this link.",
          backgroundColor: AppColors.errorRed,
        );
      }
    } catch (e) {
      showSnackBar(
        title: "Cannot open link",
        message: "Error launching URL",
        backgroundColor: AppColors.errorRed,
      );
    }
  }
}