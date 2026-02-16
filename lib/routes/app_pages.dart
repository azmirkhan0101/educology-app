import 'package:dr_dina_educology/modules/auth/screens/role_selection.dart';
import 'package:dr_dina_educology/modules/onboarding/screens/onboarding_one.dart';
import 'package:dr_dina_educology/modules/onboarding/screens/onboarding_three.dart';
import 'package:dr_dina_educology/modules/onboarding/screens/onboarding_two.dart';
import 'package:get/get.dart';

import '../modules/onboarding/screens/splash_screen.dart';
part 'app_routes.dart';

class AppPages {

  AppPages._();

  static List<GetPage> pages = [
    GetPage(
        name: AppRoutes.splash,
        page: (){
          return SplashScreen();
        }
    ),
    GetPage(
        name: AppRoutes.onBoardingOne,
        page: (){
          return OnboardingOne();
        }
    ),
    GetPage(
        name: AppRoutes.onBoardingTwo,
        page: (){
          return OnboardingTwo();
        }
    ),
    GetPage(
        name: AppRoutes.onBoardingThree,
        page: (){
          return OnboardingThree();
        }
    ),
    GetPage(
        name: AppRoutes.roleSelection,
        page: (){
          return RoleSelectionScreen();
        }
    ),
  ];
}