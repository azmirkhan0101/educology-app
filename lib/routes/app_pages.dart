import 'package:dr_dina_educology/modules/auth/screens/account_approval_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/forgot_password_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/reset_password_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/role_selection.dart';
import 'package:dr_dina_educology/modules/auth/screens/signin_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/signup_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/verify_email_screen.dart';
import 'package:dr_dina_educology/modules/home/bindings/home_binding.dart';
import 'package:dr_dina_educology/modules/home/screens/course_details_screen.dart';
import 'package:dr_dina_educology/modules/home/screens/notification_screen.dart';
import 'package:dr_dina_educology/modules/main_nav/screens/main_nav_screen.dart';
import 'package:dr_dina_educology/modules/onboarding/screens/onboarding_one.dart';
import 'package:dr_dina_educology/modules/onboarding/screens/onboarding_three.dart';
import 'package:dr_dina_educology/modules/onboarding/screens/onboarding_two.dart';
import 'package:dr_dina_educology/modules/profile/screens/about_us_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/change_password_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/privacy_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/profile_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/edit_profile_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/settings_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/support_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/terms_screen.dart';
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
    GetPage(
        name: AppRoutes.signUp,
        page: (){
          return SignupScreen();
        }
    ),
    GetPage(
        name: AppRoutes.signIn,
        page: (){
          return SignInScreen();
        }
    ),
    GetPage(
        name: AppRoutes.forgotPassword,
        page: (){
          return ForgotPasswordScreen();
        }
    ),
    GetPage(
        name: AppRoutes.verifyEmail,
        page: (){
          return VerifyEmailScreen();
        }
    ),
    GetPage(
        name: AppRoutes.resetPassword,
        page: (){
          return ResetPasswordScreen();
        }
    ),
    GetPage(
        name: AppRoutes.accountApproval,
        page: (){
          return AccountApprovalScreen();
        }
    ),
    GetPage(
        name: AppRoutes.notification,
        page: (){
          return NotificationScreen();
        }
    ),
    GetPage(
        name: AppRoutes.profile,
        page: (){
          return ProfileScreen();
        }
    ),
    GetPage(
        name: AppRoutes.editProfile,
        page: (){
          return EditProfileScreen();
        }
    ),
    GetPage(
        name: AppRoutes.support,
        page: (){
          return SupportScreen();
        }
    ),
    GetPage(
        name: AppRoutes.settings,
        page: (){
          return SettingsScreen();
        }
    ),
    GetPage(
        name: AppRoutes.changePassword,
        page: (){
          return ChangePasswordScreen();
        }
    ),
    GetPage(
        name: AppRoutes.termsConditions,
        page: (){
          return TermsScreen();
        }
    ),
    GetPage(
        name: AppRoutes.privacyPolicy,
        page: (){
          return PrivacyScreen();
        }
    ),
    GetPage(
        name: AppRoutes.aboutUs,
        page: (){
          return AboutUsScreen();
        }
    ),
    GetPage(
        name: AppRoutes.mainNav,
        page: (){
          return MainNavScreen();
        }
    ),
    GetPage(
        name: AppRoutes.courseDetails,
        page: (){
          return CourseDetailsScreen();
        },
      binding: HomeBinding()
    ),
  ];
}