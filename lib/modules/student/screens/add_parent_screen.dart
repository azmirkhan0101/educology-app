import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddParentScreen extends StatelessWidget {
  AddParentScreen({super.key});

  //Observable variable to track the selected index
  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: const Text(
          'People',
          style: TextStyle(color: Color(0xFF4A6572), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or phone no.',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF4A6572)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Find your Parents',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          const Divider(thickness: 1, height: 1),

          // List of Parents
          Expanded(
            child: ListView.separated(
              itemCount: 9,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return Obx(() {
                  final isSelected = selectedIndex.value == index;
                  return InkWell(
                    onTap: () => selectedIndex.value = index,
                    child: Container(
                      color: isSelected ? const Color(0xFFF3FAF6) : Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(100),
                             child: Container(
                               height: 45.h,
                               width: 45.w,
                               color: AppColors.greyB2,
                               child: CachedImageWidget(
                                   imageUrl: "",
                               iconSize: 28,
                               ),
                             ),
                           ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Parent name',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? const Color(0xFF6BA587) : Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                '+8801827347685',
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          // Bottom Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ButtonWidget(
                label: AppStrings.addParent,
              fontSize: 16,
              buttonHeight: 48,
              gradient: AppColors.primaryButtonGradient,
            )
          ),
        ],
      ),
    );
  }
}