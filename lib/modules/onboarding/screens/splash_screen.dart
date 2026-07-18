import 'dart:ui';

import 'package:dr_dina_educology/core/services/secure_storage_service.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/app_constants.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final storage = GetStorage();

  Future<AuthStatus> checkAuthStatus() async {

    await Future.delayed(const Duration(milliseconds: 200));

    // Read the token and verification status
    final String? token = await secureStorage.read( key: accessTokenKey );

    final bool verificationRequired = storage.read( requireVerificationKey ) ?? false;

    // If token is null or empty, the user is logged out (or never logged in)
    if ( token == null || token.isEmpty ) {//NO TOKEN -> LOGGED OUT
      if( verificationRequired ){
        return AuthStatus.loggedInNotVerified;
      }else{
        return AuthStatus.loggedOut;
      }
    }else{//TOKEN FOUND -> LOGGED IN
      return AuthStatus.loggedInAndVerified;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      body: FutureBuilder<AuthStatus>(
          future: checkAuthStatus(),
          builder: (context, snapshot){
            if( !snapshot.hasData ){
              return splashWidget();
            }

            WidgetsBinding.instance.addPostFrameCallback((_){
              final AuthStatus status = snapshot.data!;
              if( status == AuthStatus.loggedInAndVerified ){
                Get.offNamed( AppRoutes.mainNav );
              }else if( status == AuthStatus.loggedInNotVerified ){
                Get.offNamed( AppRoutes.accountApproval );
              }else{
                Get.offNamed( AppRoutes.onBoardingOne );
              }
            });

            return const SizedBox.shrink();

          }
      ),
    );
  }

  Widget splashWidget(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: 40, sigmaX: 40,),
              child: SvgPicture.asset(
                Assets.icons.splashBlurTop,
                height: 237.h,
                width: 237.w,
              ),
            ),
          ],
        ),
        Center(
          child: SvgPicture.asset(
              Assets.icons.appLogo,
            height: 160.h,
            width: 160.w,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
              child: SvgPicture.asset(
                Assets.icons.splashBlurBottom,
                height: 237.h,
                width: 237.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
