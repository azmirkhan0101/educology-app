import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../data/models/student_report/student_report_model.dart';

class ReportExporter {

  ReportExporter() {
    _initNotifications();
  }

  // 2. Export to PDF
  Future<void> exportToPDF(List<StudentReportModel> reports) async {

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
                "Learner Name",
                "Attendance",
                "Task Done",
                "Task Pending",
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
                "Total Learners: ${reports.length}",
                style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 12),
              ),
            ),
          ];
        },
      ),
    );

    final bytes = await pdf.save();
    // Changed filename to be more generic for a list
    await saveFile(bytes, "course_report.pdf", isBytes: true);
  }

  // Helper: Save file to storage
  Future<void> saveFile(dynamic content, String fileName, {bool isBytes = false}) async {
    try {
      // 1. Run a quick cleanup of old exports before creating a new one
      await clearOldExportCache();

      // 1. Get the temporary directory (Requires 0 permissions on both Android and iOS)
      final tempDir = await getTemporaryDirectory();
      final exportDir = Directory("${tempDir.path}/exports");
      if (!await exportDir.exists()) {
        await exportDir.create(recursive: true);
      }
      final tempFile = File("${exportDir.path}/$fileName");

      // 2. Write the generated content to the temporary file
      if (isBytes) {
        await tempFile.writeAsBytes(content);
      } else {
        await tempFile.writeAsString(content);
      }
      // 3. Trigger the native "Save As" dialog
      // This allows the user to save the file directly to "Downloads", "Documents", "Drive", etc.
      final params = SaveFileDialogParams(sourceFilePath: tempFile.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        _showNotification(tempFile.path, fileName);
      } else {
        // 4. Clean up the temporary file from cache
        if (await tempFile.exists()) {
          await tempFile.delete();
        }
      }
    } catch (e) {
      showSnackBar(
        title: 'Error',
        message: 'Failed to export file: $e',
        backgroundColor: AppColors.errorRed,
      );
    }
  }

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize settings for Android and iOS
  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    //iOS Specific: Configure Darwin initialization settings
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      // Set to false to request permissions on-demand later
      requestBadgePermission: false,
      requestSoundPermission: false,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      defaultPresentBanner:
      true, // Required to show foreground banners on iOS 14+
      defaultPresentList:
      true, // Required to show in notification center on iOS 14+
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async{
        if (details.payload != null && details.payload!.isNotEmpty) {
          //Trigger the file opening logic
          await _openDownloadedFile(details.payload!);
        }
      },
    );

    // Request permissions programmatically (Handles both iOS and Android 13+)
    await _requestPermissions();
  }

  //Helper to request permissions gracefully on both platforms
  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
      >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      // Required for Android 13 (API level 33) and higher
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
      >()
          ?.requestNotificationsPermission();
    }
  }

  Future<void> _openDownloadedFile(String filePath) async {

    // Crucial: Give the OS a brief moment (500ms) to bring your app fully into the
    // foreground and bind its window token before launching the external file viewer intent.
    await Future.delayed(const Duration(milliseconds: 500));

    final file = File(filePath);
    if (!await file.exists()) {
      showSnackBar(
        title: "File not found",
        message: "The temporary file could not be located.",
        backgroundColor: AppColors.errorRed,
      );
      return;
    }
    final result = await OpenFile.open(filePath);

    if (result.type != ResultType.done) {
      // Handle errors (e.g., file not found or no app to open it)
      showSnackBar(title: "Cannot open file", message: result.message, backgroundColor: AppColors.warningYellow);
    }
  }

  void _showNotification(String path, String fileName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'export_channel_id',
      'File Exports',
      channelDescription: 'Notifications for saved PDF files',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true
    );

    //iOS Specific: Configure iOS native notification presentation options
    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
    DarwinNotificationDetails(
      presentAlert: true, // Display the banner on screen
      presentBadge: true, // Update the application badge
      presentSound: true, // Play default sound
      presentBanner: true, // Forces the heads-up banner to pop up
      presentList: true, // Places it in the list when pulled down
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics
    );

    // Get only the filename for the title
    String fileName = path.split('/').last;
    //String fileName = path;

    await _notificationsPlugin.show(
      id: 0, // Notification ID
      title: 'File Saved Successfully',
      body: fileName, // The body shows the filename
      notificationDetails: platformChannelSpecifics,
      payload: path, // We pass the path so tapping the notification can open the file
    );
  }

  //Deletes cached exports older than 24 hours
  Future<void> clearOldExportCache() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final exportDir = Directory('${tempDir.path}/exports');

      if (await exportDir.exists()) {
        final now = DateTime.now();
        await for (final file in exportDir.list()) {
          if (file is File) {
            final lastModified = await file.lastModified();
            if (now.difference(lastModified).inHours > 6) {
              await file.delete();
            }
          }
        }
      }
    } catch (_) {
    }
  }
}
