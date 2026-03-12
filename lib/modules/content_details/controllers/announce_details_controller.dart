import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/announcement/announce_model.dart';
import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnounceDetailsController extends GetxController{

  final RoleService roleService = Get.find<RoleService>();
  late Role role;
  late AnnounceModel announceModel;
  late List<CommentModel> comments;

  TextEditingController commentController = TextEditingController();


  @override
  void onInit() {

    announceModel = Get.arguments;
    comments = announceModel.comments;
    role = roleService.getUpdatedRole();

    super.onInit();
  }
}