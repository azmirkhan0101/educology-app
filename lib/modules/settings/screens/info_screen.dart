import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/settings/controllers/info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/extensions.dart';

class InfoScreen extends StatelessWidget {
  InfoScreen({super.key});

  final InfoController controller = Get.find<InfoController>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: TextWidget(text: controller.pageType.label,
        fontSize: isTab ? 12.sp : 18,
          fontWeight: FontWeight.w700,
        ),
        leading: BackButton(style: ButtonStyle(iconSize: isTab ? WidgetStatePropertyAll(30) : WidgetStatePropertyAll(0)),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx((){
          if( controller.isInfoLoading.value ){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            if( controller.info.value.isEmpty ){
              return Center( child: Text("No data found", style: TextStyle( fontSize:isTab ? 10.sp : null),),);
            }else{
              return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                      child: Html(
                        data: controller.info.value,
                        style: {
                          "body": Style(
                            fontSize: FontSize( isTab ? 10.sp : 14),
                            lineHeight: const LineHeight(1.6),
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          "h1": Style(fontSize: FontSize(22)),
                          "h2": Style(fontSize: FontSize(18)),
                        },
                      )
                  )
              );
            }
          }
        })
      )
    );
  }
}
