import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart' as OpenAppSettings;
import 'package:permission_handler/permission_handler.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../data/models/student_report/student_report_model.dart';

class AnalyticsExporter {

  Future<Directory?>? getExportDirectory() async {
    try {
      // Android: request permission (same as your original code)
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkVersion = androidInfo.version.sdkInt;

        if (sdkVersion >= 30) {
          // Android 11+ requires MANAGE_EXTERNAL_STORAGE
          var status = await Permission.manageExternalStorage.status;
          if (!status.isGranted) {
            status = await Permission.manageExternalStorage.request();
          }

          if (status.isPermanentlyDenied) {
            await OpenAppSettings.openAppSettings();
            showSnackBar(title: 'Permission Required', message: 'Please grant storage permission in app settings', backgroundColor: AppColors.errorRed);
            return null;
          }

          if (!status.isGranted) {
            showSnackBar(title: 'Error', message: 'Storage permission denied. Cannot save PDF.', backgroundColor: AppColors.errorRed);
            return null;
          }
        } else {
          // For older Android versions
          var status = await Permission.storage.status;
          if (!status.isGranted) {
            status = await Permission.storage.request();
          }

          if (status.isPermanentlyDenied) {
            await OpenAppSettings.openAppSettings();
            showSnackBar(title: 'Permission Required', message: 'Please grant storage permission in app settings', backgroundColor: AppColors.warningYellow);
            return null;
          }

          if (!status.isGranted) {
            showSnackBar(title: 'Error', message: 'Storage permission denied. Cannot save PDF.', backgroundColor: AppColors.errorRed);
            return null;
          }
        }
      }

      Directory? directory;

      if (Platform.isAndroid) {
        //Android: use public storage directory
        final externalDir = await getExternalStorageDirectory();
        if (externalDir == null) {
          showSnackBar(title: 'Error', message: 'Cannot access external storage', backgroundColor: AppColors.errorRed);
          return null;
        }

        // Extract the root path (/storage/emulated/0)
        final rootPath = externalDir.path.split('/Android')[0];
        directory = Directory('$rootPath/Invoices');

        debugPrint('Root path: $rootPath');
        debugPrint('Target directory: ${directory.path}');
      } else if (Platform.isIOS) {
        // ✅ iOS: Save to user-visible Documents directory
        // This directory is accessible via the Files app under “On My iPhone/<AppName>/”
        final docsDir = await getApplicationDocumentsDirectory();
        directory = Directory('${docsDir.path}/Invoices');

        debugPrint('iOS visible directory: ${directory.path}');
      } else {
        directory = await getTemporaryDirectory();
        directory = Directory('${directory.path}/Invoices');
      }

      // Create directory if it doesn't exist
      if (!await directory.exists()) {
        try {
          await directory.create(recursive: true);
          debugPrint('Directory created: ${directory.path}');
        } catch (e) {
          debugPrint('Error creating directory: $e');
          showSnackBar(title: 'Error', message: 'Failed to create directory: $e', backgroundColor: AppColors.errorRed);
          return null;
        }
      }

      // Check if directory is writable
      try {
        final testFile = File('${directory.path}/test.txt');
        await testFile.writeAsString('test');
        await testFile.delete();
        debugPrint('Directory is writable');
      } catch (e) {
        debugPrint('Directory is not writable: $e');
        showSnackBar(title: 'Error', message: 'Cannot write to directory: $e', backgroundColor: AppColors.errorRed);
        return null;
      }
      if( directory != null ){
        return directory;
      }else{
        return null;
      }
    } catch (e) {
      showSnackBar(title: 'Error', message: 'Failed to save PDF to storage: $e', backgroundColor: AppColors.errorRed);
      return null;
    }
  }

  // 2. Export to PDF
  Future<void> exportToPDF(List<StudentReportModel> reports) async {
    Directory? directory = await getExportDirectory();

    if (directory == null) {
      return;
    } else {
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              pw.Header(
                level: 0,
                child: pw.Text("Course Report",
                    style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)
                ),
              ),
              pw.SizedBox(height: 20),

              // --- Student Data Table ---
              pw.TableHelper.fromTextArray(
                border: pw.TableBorder.all(width: 0.5),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                headerHeight: 30,
                cellHeight: 25,
                cellAlignment: pw.Alignment.centerLeft,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headers: [
                  "Student Name",
                  "Attendance",
                  "HW Done",
                  "HW Pending",
                  "Grade"
                ],
                data: reports.map((student) => [
                  student.studentName,
                  student.attendance,
                  student.hwCompleted,
                  student.hwPending,
                  student.examGrade,
                ]).toList(),
              ),

              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 20),
                child: pw.Text(
                  "Total Students: ${reports.length}",
                  style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 12),
                ),
              ),
            ];
          },
        ),
      );

      final bytes = await pdf.save();
      // Changed filename to be more generic for a list
      await _saveFile(bytes, "course_report.pdf", isBytes: true, directory: directory);
    }
  }

  // Helper: Save file to storage
  Future<void> _saveFile(dynamic content, String fileName, {bool isBytes = false, required Directory directory}) async {

    final file = File("${directory.path}/$fileName");

    try {
      if (isBytes) {
        await file.writeAsBytes(content);
      } else {
        await file.writeAsString(content);
      }
      _showNotification(file.path);
    } catch (e) {
    }
  }

  // Helper: Permissions
  Future<bool> _requestPermission() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      status = await Permission.manageExternalStorage.request();
    }
    return status.isGranted;
  }

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  AnalyticsExporter() {
    _initNotifications();
  }

  // Initialize settings for Android and iOS
  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async{
        if (details.payload != null && details.payload!.isNotEmpty) {
          /// Trigger the file opening logic
          await _openDownloadedFile(details.payload!);
        }
      },
    );
  }

  Future<void> _openDownloadedFile(String filePath) async {
    final result = await OpenFilex.open(filePath);

    if (result.type != ResultType.done) {
      // Handle errors (e.g., file not found or no app to open it)
      showSnackBar(title: "Cannot open file", message: "Try opening from file manager.", backgroundColor: AppColors.warningYellow);
    }
  }

  void _showNotification(String path) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'export_channel_id',
      'File Exports',
      channelDescription: 'Notifications for saved CSV and PDF files',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Get only the filename for the title
    String fileName = path.split('/').last;
    //String fileName = path;

    await _notificationsPlugin.show(
      id: 0, // Notification ID
      title: 'File Saved Successfully',
      body: '$fileName', // The body shows the filename
      notificationDetails: platformChannelSpecifics,
      payload: path, // We pass the path so tapping the notification can open the file
    );
  }
}
