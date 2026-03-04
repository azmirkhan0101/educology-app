import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/profile/controllers/terms_controller.dart';
import 'package:dr_dina_educology/modules/profile/widgets/profile_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shimmer/shimmer.dart';

class TermsScreen extends StatelessWidget {
  TermsScreen({super.key});

  final TermsController controller = Get.find<TermsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: TextWidget(text: AppStrings.termsConditions,
        fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_sharp)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx((){
          if( controller.isTermsLoading.value ){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            if( controller.terms.value.isEmpty ){
              return const Center( child: Text("No data found"),);
            }else{
              return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                      child: Html(
                        data: controller.terms.value,
                        style: {
                          "body": Style(
                            fontSize: FontSize(14),
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
