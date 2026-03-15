import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:dr_dina_educology/data/models/content_details/content_details_model.dart';
import 'package:dr_dina_educology/data/models/document/documents_model.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/course_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_snackbar.dart';

class ContentDetailsController extends GetxController{

  final CourseDetailsController courseDetailsController = Get.isRegistered<CourseDetailsController>() ? Get.find<CourseDetailsController>() : Get.put(CourseDetailsController());
  final ApiService apiService = Get.find<ApiService>();
  late Map<String, dynamic> arguments;
  late String appTitle;
  late ContentDetailsType contentDetailsType;
  final RoleService roleService = Get.find<RoleService>();
  late Role role;
  late ContentDetailsModel contentDetailsModel;
  final RxList<String> documents = <String>[].obs;
  final RxList<CommentModel> comments = <CommentModel>[].obs;

  TextEditingController commentController = TextEditingController();

  @override
  void onInit() async{

    arguments = Get.arguments;
    contentDetailsType = arguments["contentDetailsType"];
    contentDetailsModel = arguments["contentDetailsModel"];
    comments.value = contentDetailsModel.comments;

    appTitle = contentDetailsType.label;
    role = roleService.getUpdatedRole();

    documents.value = contentDetailsModel.documents;

    super.onInit();
  }

  //========================POST COMMENT================================
  Future<void> postComment({required String comment}) async {
    late Map<String, dynamic> payLoad;
    bool isClass = contentDetailsType == ContentDetailsType.cClass;
    bool isHomeWork = contentDetailsType == ContentDetailsType.homeWork;
    bool isExam = contentDetailsType == ContentDetailsType.exam;

    if( isClass ){//CLASS COMMENT
      payLoad = {
        "classId": contentDetailsModel.id,
        "comment": comment
      };
    }else{//TASK COMMENT
      payLoad = {
        "taskId": contentDetailsModel.id,
        "comment": comment
      };
    }

    ApiResponse response = await apiService.networkRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.comment,
      body: payLoad
    );

    if( response.statusCode == 201 ){
      if( isClass ){
        courseDetailsController.getClasses();
      }else if( isHomeWork ){
        courseDetailsController.getHomeworks();
      }else if( isExam ){
        courseDetailsController.getExams();
      }
      comments.value.add(CommentModel.fromJson(response.data['data']));
      comments.refresh();
    }else{
      showSnackBar(title: "Failed", message: response.data?["message"] ?? "Something went wrong", backgroundColor: AppColors.errorRed);
    }

    commentController.clear();
  }

  //========================POST REPLY===================================
  Future<void> postReply({required int commentIndex, required String reply}) async {
    late Map<String, dynamic> payLoad;
    bool isClass = contentDetailsType == ContentDetailsType.cClass;
    bool isHomeWork = contentDetailsType == ContentDetailsType.homeWork;
    bool isExam = contentDetailsType == ContentDetailsType.exam;

    if( isClass ){
      payLoad = {
        "classId": contentDetailsModel.id,
        "parentCommentId": comments.value[commentIndex].id,
        "comment": reply
      };
    }else{
      payLoad = {
        "taskId": contentDetailsModel.id,
        "parentCommentId": comments.value[commentIndex].id,
        "comment": reply
      };
    }

    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: true,
        endPoint: ApiEndpoints.comment,
        body: payLoad
    );

    if( response.statusCode == 201 ){
      if( isClass ){
        courseDetailsController.getClasses();
      }else if( isHomeWork ){
        courseDetailsController.getHomeworks();
      }else if( isExam ){
        courseDetailsController.getExams();
      }
      CommentModel replyModel = CommentModel.fromJson(response.data['data']);
      comments.value[commentIndex].replies.add( replyModel );
      comments.refresh();
    }else{
      showSnackBar(title: "Failed", message: response.data?["message"] ?? "Something went wrong", backgroundColor: AppColors.errorRed);
    }

    commentController.clear();
  }

  //OPEN CLASS LINK IN BROWSER
  Future<void> openLinkInBrowser({required String classLink}) async {
    final Uri url = Uri.parse(classLink);

    // Check if the device is capable of handling the URL
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Forces external browser
    )) {
      throw Exception('Could not launch');
    }
  }

  //=========================GET PDF FILE SIZE==========================
  Future<String> getPdfSize({required String url}) async {
    try {
      final response = await http.head(Uri.parse(url));

      if (response.statusCode == 200) {
        String? contentLength = response.headers['content-length'];

        if (contentLength != null) {
          int bytes = int.parse(contentLength);
          double mb = bytes / (1024 * 1024);
          return "${mb.toStringAsFixed(2)} MB";
        } else {
          return "";
        }
      }else{
        return "";
      }
    } catch (e) {
      print("Error fetching file size: $e");
      return "";
    }
  }

  @override
  void onClose() {
    commentController.dispose();
    comments.clear();

    super.onClose();
  }

}