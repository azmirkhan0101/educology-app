import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/services/firebase_notification_service.dart';
import 'educology_main_app.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(RoleService());
  await Get.putAsync(() {
    return ApiService().init();
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotificationService.instance.initialize();

  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");

  runApp( const EducologyMainApp() );
}