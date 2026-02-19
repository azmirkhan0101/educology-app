import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'main_app.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(RoleService());
  runApp( const MainApp() );
}