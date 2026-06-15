import 'package:dr_dina_educology/core/assets_gen/fonts.gen.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EducologyMainApp extends StatelessWidget {
  const EducologyMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      //splitScreenMode: true,
      builder: (_, child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            quill.FlutterQuillLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
          ],
          theme: ThemeData(
            fontFamily: FontFamily.inter,
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                // For iOS: Dark icons (use .light for white icons on a dark background)
                statusBarBrightness: Brightness.light,
                // For Android: Dark icons
                statusBarIconBrightness: Brightness.dark,
              ),
            )
          ),
          getPages: AppPages.pages,
          initialRoute: AppRoutes.splash,
        );
      },
    );
  }
}

