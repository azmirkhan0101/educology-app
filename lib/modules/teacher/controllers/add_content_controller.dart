import 'dart:io';

import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:get/get.dart';

class AddContentController extends GetxController{

  ApiService apiService = Get.find<ApiService>();
  late Map<String, dynamic> arguments;
  late String appTitle;
  late AddContentType contentType;

  @override
  void onInit() {

    arguments = Get.arguments;
    contentType = arguments["contentType"];
    appTitle = contentType.label;

    super.onInit();
  }

  String formattedText = "";
  File? question;


  uploadExam() async{

    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: true,
        endPoint: ApiEndpoints.uploadExam,
        body: {}
    );

    if( response.statusCode == 200 ){

    }else{

    }



  }
}