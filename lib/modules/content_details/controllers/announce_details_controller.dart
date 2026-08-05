import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:dr_dina_educology/data/models/announcement/announce_model.dart';
import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/course_details_controller.dart';
import 'package:dr_dina_educology/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnounceDetailsController extends GetxController {

  final CourseDetailsController courseDetailsController = Get.isRegistered<CourseDetailsController>() ? Get.find<CourseDetailsController>() : Get.put(CourseDetailsController());
  final ApiService apiService = Get.find<ApiService>();
  final RoleService roleService = Get.find<RoleService>();
  late Role role;
  late AnnounceModel announceModel;
  final RxList<CommentModel> comments = <CommentModel>[].obs;

  TextEditingController commentController = TextEditingController();
  final ProfileController profileController = Get.isRegistered<ProfileController>()
  ? Get.find<ProfileController>()
      : Get.put(ProfileController());
  late String myUserId;

  @override
  void onInit() async{
    announceModel = Get.arguments;
    comments.value = announceModel.comments;
    role = roleService.getUpdatedRole();

    myUserId = profileController.profileModel.value?.id ?? "";

    super.onInit();
  }

  //POST COMMENT
  Future<void> postComment({required String comment}) async {
    Map<String, dynamic> payLoad = {
      "announcementId": announceModel.id,
      "comment": comment,
    };

    ApiResponse response = await apiService.networkRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.comment,
      body: payLoad,
    );

    if( response.statusCode == 201 ){
      courseDetailsController.getAnnouncements();
      comments.value.add(CommentModel.fromJson(response.data['data']));
      comments.refresh();
    }else{
      showSnackBar(title: "Failed", message: response.data?["message"] ?? "Something went wrong", backgroundColor: AppColors.errorRed);
    }

    commentController.clear();
  }


  //POST REPLY
  Future<void> postReply({required int commentIndex, required String reply}) async {
    Map<String, dynamic> payLoad = {
      "announcementId": announceModel.id,
      "parentCommentId": comments.value[commentIndex].id,
      "comment": reply
    };

    ApiResponse response = await apiService.networkRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.comment,
      body: payLoad
    );

    if( response.statusCode == 201 ){
      courseDetailsController.getAnnouncements();
      CommentModel replyModel = CommentModel.fromJson(response.data['data']);
      comments.value[commentIndex].replies.add( replyModel );
      comments.refresh();
    }else{
      showSnackBar(title: "Failed", message: response.data?["message"] ?? "Something went wrong", backgroundColor: AppColors.errorRed);
    }

    commentController.clear();
  }


  //========================REPORT COMMENT====================
  Future<void> reportComment({required String commentId, required int commentIndex, int replyIndex = -1, bool isReply = false}) async{
    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: true,
        endPoint: ApiEndpoints.reportComment(commentId: commentId),
        body: {
          "reason": "Contains inappropriate language"
        }
    );

    if( response.statusCode == 200 ){
      if( isReply ){
        comments.value[commentIndex].replies.removeAt(replyIndex);
      }else {
        comments.removeAt(commentIndex);
      }
      showSnackBar(title: "Reported!", message: "This comment has been reported!", backgroundColor: AppColors.warningYellow);
    }else{
      showApiSnackBar(statusCode: response.statusCode, data: response.data);
    }
  }

  @override
  void onClose() {

    commentController.dispose();
    comments.clear();

    super.onClose();
  }
}
