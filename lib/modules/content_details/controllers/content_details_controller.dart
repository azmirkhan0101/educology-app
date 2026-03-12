import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/class/class_model.dart';
import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/homework_exam/homework_exam_model.dart';

class ContentDetailsController extends GetxController{

  late Map<String, dynamic> arguments;
  late String appTitle;
  late ContentDetailsType contentDetailsType;
  final RoleService roleService = Get.find<RoleService>();
  late Role role;
  late ClassModel classModel;
  late HomeworkExamModel homeworkExamModel;
  late List<CommentModel> comments;

  TextEditingController commentController = TextEditingController();

  @override
  void onInit() {

    arguments = Get.arguments;
    contentDetailsType = arguments["contentDetailsType"];
    comments = arguments["comments"];
    appTitle = contentDetailsType.label;
    role = roleService.getUpdatedRole();

    if( contentDetailsType == ContentDetailsType.cClass ){
      classModel = arguments["classModel"] as ClassModel;
    }else{
      homeworkExamModel = arguments["homeworkExamModel"] as HomeworkExamModel;
    }

    super.onInit();
  }
}