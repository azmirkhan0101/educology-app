import 'package:dr_dina_educology/modules/auth/bindings/forgot_password_binding.dart';
import 'package:dr_dina_educology/modules/auth/bindings/otp_verify_binding.dart';
import 'package:dr_dina_educology/modules/auth/bindings/reset_password_binding.dart';
import 'package:dr_dina_educology/modules/auth/bindings/signin_binding.dart';
import 'package:dr_dina_educology/modules/auth/bindings/signup_binding.dart';
import 'package:dr_dina_educology/modules/auth/screens/account_approval_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/forgot_password_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/reset_password_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/role_selection.dart';
import 'package:dr_dina_educology/modules/auth/screens/signin_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/signup_screen.dart';
import 'package:dr_dina_educology/modules/auth/screens/verify_email_screen.dart';
import 'package:dr_dina_educology/modules/content_details/bindings/announce_details_binding.dart';
import 'package:dr_dina_educology/modules/content_details/bindings/content_details_binding.dart';
import 'package:dr_dina_educology/modules/content_details/screens/announcement_details_screen.dart';
import 'package:dr_dina_educology/modules/content_details/screens/content_details_screen.dart';
import 'package:dr_dina_educology/modules/course_details/bindings/course_details_binding.dart';
import 'package:dr_dina_educology/modules/course_details/bindings/participants_binding.dart';
import 'package:dr_dina_educology/modules/course_details/bindings/single_attendance_binding.dart';
import 'package:dr_dina_educology/modules/course_details/bindings/student_progress_binding.dart';
import 'package:dr_dina_educology/modules/course_details/screens/course_details_screen.dart';
import 'package:dr_dina_educology/modules/course_details/screens/participant_screen.dart';
import 'package:dr_dina_educology/modules/course_details/screens/single_attendance_screen.dart';
import 'package:dr_dina_educology/modules/course_details/screens/student_progress_screen.dart';
import 'package:dr_dina_educology/modules/course_details/screens/view_all_marks_screen.dart';
import 'package:dr_dina_educology/modules/main_nav/bindings/main_nav_binding.dart';
import 'package:dr_dina_educology/modules/main_nav/screens/main_nav_screen.dart';
import 'package:dr_dina_educology/modules/onboarding/screens/onboarding_one.dart';
import 'package:dr_dina_educology/modules/onboarding/screens/onboarding_three.dart';
import 'package:dr_dina_educology/modules/onboarding/screens/onboarding_two.dart';
import 'package:dr_dina_educology/modules/settings/bindings/info_binding.dart';
import 'package:dr_dina_educology/modules/settings/screens/info_screen.dart';
import 'package:dr_dina_educology/modules/settings/screens/change_password_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/edit_profile_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/support_screen.dart';
import 'package:dr_dina_educology/modules/student/bindings/add_parent_binding.dart';
import 'package:dr_dina_educology/modules/student/bindings/submit_answer_binding.dart';
import 'package:dr_dina_educology/modules/student/screens/add_parent_screen.dart';
import 'package:dr_dina_educology/modules/student/screens/submit_answer_screen.dart';
import 'package:dr_dina_educology/modules/teacher/bindings/add_content_binding.dart';
import 'package:dr_dina_educology/modules/teacher/bindings/check_answer_binding.dart';
import 'package:dr_dina_educology/modules/teacher/bindings/course_overview_binding.dart';
import 'package:dr_dina_educology/modules/teacher/bindings/provide_mark_binding.dart';
import 'package:dr_dina_educology/modules/teacher/bindings/student_report_binding.dart';
import 'package:dr_dina_educology/modules/teacher/bindings/take_attendance_binding.dart';
import 'package:dr_dina_educology/modules/teacher/screens/add_content_screen.dart';
import 'package:dr_dina_educology/modules/teacher/screens/check_answer_screen.dart';
import 'package:dr_dina_educology/modules/teacher/screens/course_overview_screen.dart';
import 'package:dr_dina_educology/modules/teacher/screens/provide_mark_screen.dart';
import 'package:dr_dina_educology/modules/teacher/screens/students_report_screen.dart';
import 'package:dr_dina_educology/modules/teacher/screens/take_attendance_screen.dart';
import 'package:get/get.dart';

import '../modules/course_details/bindings/view_marks_binding.dart';
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
        },
      binding: SignupBinding()
    ),
    GetPage(
        name: AppRoutes.signIn,
        page: (){
          return SignInScreen();
        },
      binding: SigninBinding()
    ),
    GetPage(
        name: AppRoutes.forgotPassword,
        page: (){
          return ForgotPasswordScreen();
        },
      binding: ForgotPasswordBinding()
    ),
    GetPage(
        name: AppRoutes.verifyEmail,
        page: (){
          return VerifyEmailScreen();
        },
      binding: OtpVerifyBinding()
    ),
    GetPage(
        name: AppRoutes.resetPassword,
        page: (){
          return ResetPasswordScreen();
        },
      binding: ResetPasswordBinding()
    ),
    GetPage(
        name: AppRoutes.accountApproval,
        page: (){
          return AccountApprovalScreen();
        }
    ),
    GetPage(
        name: AppRoutes.mainNav,
        page: (){
          return MainNavScreen();
        },
      binding: MainNavBinding()
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
        name: AppRoutes.changePassword,
        page: (){
          return ChangePasswordScreen();
        }
    ),
    GetPage(
        name: AppRoutes.info,
        page: (){
          return InfoScreen();
        },
      binding: InfoBinding()
    ),
    GetPage(
        name: AppRoutes.courseDetails,
        page: (){
          return CourseDetailsScreen();
        },
      binding: CourseDetailsBinding()
    ),
    GetPage(
        name: AppRoutes.courseOverview,
        page: (){
          return CourseOverviewScreen();
        },
        binding: CourseOverviewBinding()
    ),
    GetPage(
      name: AppRoutes.studentProgress,
      page: (){
        return StudentProgressScreen();
      },
      binding: StudentProgressBinding()
    ),
    GetPage(
      name: AppRoutes.participants,
      page: (){
        return ParticipantScreen();
      },
      binding: ParticipantsBinding()
    ),
    GetPage(
      name: AppRoutes.singleAttendance,
      page: (){
        return SingleAttendanceScreen();
      },
      binding: SingleAttendanceBinding()
    ),
    GetPage(
      name: AppRoutes.addContent,
      page: (){
        return AddContentScreen();
      },
      binding: AddContentBinding()
    ),
    GetPage(
      name: AppRoutes.viewAllMarks,
      page: (){
        return ViewAllMarksScreen();
      },
      binding: ViewMarksBinding()
    ),
    GetPage(
      name: AppRoutes.studentsReport,
      page: (){
        return StudentsReportScreen();
      },
      binding: StudentReportBinding()
    ),
    GetPage(
      name: AppRoutes.announcementDetails,
      page: (){
        return AnnouncementDetailsScreen();
      },
      binding: AnnounceDetailsBinding()
    ),
    GetPage(
      name: AppRoutes.contentDetails,
      page: (){
        return ContentDetailsScreen();
      },
      binding: ContentDetailsBinding()
    ),
    GetPage(
        name: AppRoutes.addParent,
        page: (){
          return AddParentScreen();
        },
        binding: AddParentBinding()
    ),
    GetPage(
        name: AppRoutes.submitAnswer,
        page: (){
          return SubmitAnswerScreen();
        },
        binding: SubmitAnswerBinding()
    ),
    GetPage(
        name: AppRoutes.takeAttendance,
        page: (){
          return TakeAttendanceScreen();
        },
      binding: TakeAttendanceBinding()
    ),
    GetPage(
      name: AppRoutes.checkAnswer,
      page: (){
        return CheckAnswerScreen();
      },
      binding: CheckAnswerBinding()
    ),
    GetPage(
      name: AppRoutes.provideMark,
      page: (){
        return ProvideMarkScreen();
      },
      binding: ProvideMarkBinding()
    ),
  ];
}