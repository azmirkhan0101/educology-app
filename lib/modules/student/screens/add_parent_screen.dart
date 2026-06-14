import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/utils/extensions.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:dr_dina_educology/modules/student/controllers/add_parent_controller.dart';
import 'package:dr_dina_educology/modules/student/widgets/parent_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddParentScreen extends StatelessWidget {
  AddParentScreen({super.key});

  final AddParentController controller = Get.find<AddParentController>();
  //Observable variable to track the selected index
  //final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black, size: isTab ? 30 : null,)),
        title: Text(
          'People',
          style: TextStyle(fontSize: isTab ? 12.sp : null, color: Color(0xFF4A6572), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //========================Search Bar=========================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              style: TextStyle(fontSize: isTab ? 10.sp : null),
              onChanged: (query){
                controller.filterParents(query);
              },
              decoration: InputDecoration(
                hintText: 'Search by name or phone no.',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: isTab ? 10.sp : null),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Find your Supervisors',
              style: TextStyle(fontSize: isTab ? 12.sp : 18, fontWeight: FontWeight.bold),
            ),
          ),

          const Divider(thickness: 1, height: 1),

          //===================List of Parents========================
          Expanded(
            child: Obx((){
              if( controller.isParentsLoading.value ){
                return const Center(child: CircularProgressIndicator(color: AppColors.primaryGold,));
              }
              if( controller.filteredParents.isEmpty ){
                return Center(child: Text("No Supervisors Found", style: TextStyle(fontSize: isTab ? 10.sp : null),));
              }
              return ListView.separated(
                itemCount: controller.filteredParents.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {

                  final StaffModel staffModel = controller.filteredParents[index];

                  return Obx(() {

                    final isSelected = controller.selectedParentId.value == staffModel.id;

                    return ParentItemWidget(
                        onPressed: (){
                          controller.selectedParentId.value = staffModel.id;
                          controller.filteredParents.refresh();
                        },
                        isSelected: isSelected,
                        staffModel: StaffModel(
                            id: staffModel.id,
                            fullName: staffModel.fullName,
                            image: staffModel.image,
                            email: staffModel.email,
                            contact: staffModel.contact
                        )
                    );
                  });
                },
              );
            })
          ),
          // Bottom Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx((){
              return ButtonWidget(
                isLoading: controller.isUploading.value,
                label: AppStrings.addParent,
                fontSize: 16,
                buttonHeight: 48,
                gradient: AppColors.primaryButtonGradient,
                onPressed: (){
                  controller.addParent();
                },
              );
            })
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}