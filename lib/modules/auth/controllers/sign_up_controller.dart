import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_validator.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {

  GlobalKey<FormState>? _formKey;
  bool _hasSubmitted = false;
  RxBool isAgreed = false.obs;
  late Role role;

  @override
  void onInit() {

    Role role = Get.arguments as Role? ?? Role.student;
    this.role = role;

    firstNameController.addListener(_onTextChanged);
    lastNameController.addListener(_onTextChanged);
    emailController.addListener(_onTextChanged);
    passwordController.addListener(_onTextChanged);
    confirmPasswordController.addListener(_onTextChanged);
    dateController.addListener(_onTextChanged);

    super.onInit();
  }

  void setFormKey(GlobalKey<FormState> key) {
    _formKey = key;
  }

  void markSubmitted() {
    _hasSubmitted = true;
    _formKey?.currentState?.validate();
  }

  void _onTextChanged(){
    if( _formKey != null && _hasSubmitted ){
      _formKey!.currentState!.validate();
    }
  }

  final ApiService apiService = Get.find<ApiService>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();//FOR VALIDATION ONLY
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  //final TextEditingController locationController = TextEditingController();
  String contactNumber = "";
  //late DateTime? dateOfBirth;

  final Rx<File?> profileImage = Rx<File?>(null);

  final storage = GetStorage();
  RxBool isSignupLoading = false.obs;

  //SIGN UP
  Future<void> signup() async {
    if (!isPhoneNumberValid(number: contactNumber)) {
      showSnackBar(
        title: "Phone number is required!",
        message: "",
        backgroundColor: AppColors.warningYellow,
      );
      return;
    }

    if (isSignupLoading.value) {
      return;
    }

    isSignupLoading.value = true;
    String? token;
    if (Platform.isIOS) {
      String? apnsToken;
      for( int i = 0; i < 5; i++ ){
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();

        if( apnsToken != null ){
          break;
        }
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    try{
      token = await FirebaseMessaging.instance.getToken();
    }catch(e){
      print("FCM error: $e");
    }
    print("FCM token: $token");

    // Map<String, dynamic> signupPayload = {
    //   "firstName": firstNameController.text.trim(),
    //   "lastName": firstNameController.text.trim(),
    //   "email": emailController.text.trim(),
    //   "password": passwordController.text.trim(),
    //   "location": locationController.text.trim(),
    //   "contact": contactNumber,
    //   "dob": "${dateOfBirth?.toIso8601String()}",
    //   "fcmToken": token ?? ""
    // };

    Map<String, dynamic> signupPayload = {
      "role": role.name,
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "contact": contactNumber,
      "fcmToken": token ?? ""
    };

    final ApiResponse response = await apiService.multipartRequest(
      isAuthRequired: false,
        endPoint: ApiEndpoints.signup,
        fields: signupPayload,
        imageKey: "image",
        method: "POST",
      image: profileImage.value
    );

    isSignupLoading.value = false;

    if ( response.statusCode == 201 ) {//ACCOUNT CREATED
      showSnackBar(title: "Account Created", message: "Successfully created account.", backgroundColor: AppColors.greenPrimary);

      storage.write( emailKey, emailController.text.trim() );
      storage.write( requireVerificationKey, true );
      Map<String, dynamic> arguments = {
        emailKey : emailController.text.trim(),
        isSignupKey : true
      };
      Get.offAndToNamed( AppRoutes.verifyEmail, arguments: arguments );
    }else if( response.statusCode == 400 ){//PHONE NUMBER EXISTS
      showSnackBar(title: "Failed!", message: response.data?['message'] ?? "Phone number already exist.", backgroundColor: AppColors.errorRed);
    }else if (response.statusCode == 409) {//USER ALREADY EXISTS
      showSnackBar(
        title: "User Exists!",
        message: response.data?['message'] ?? "User already exist with this email. Try login instead.",
        backgroundColor: AppColors.warningYellow,
      );
    }else if (response.statusCode == 408) {//TIME OUT
      timeOutSnackBar();
    }else if (response.statusCode == 503) {//NO INTERNET
      noInternetSnackBar();
    } else {
      errorSnackBar();
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
