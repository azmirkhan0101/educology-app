import 'package:dr_dina_educology/binding/initial_binding.dart';
import 'package:dr_dina_educology/core/assets_gen/fonts.gen.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      //splitScreenMode: true,
      builder: (_, child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: FontFamily.inter
          ),
          initialBinding: InitialBinding(),
          getPages: AppPages.pages,
          initialRoute: AppRoutes.courseDetails,
        );
      },
    );
  }
}

