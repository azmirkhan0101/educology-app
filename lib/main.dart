import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import 'main_app.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp( const MainApp() );
}