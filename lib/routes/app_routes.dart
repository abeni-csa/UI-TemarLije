import 'package:get/get.dart';
import 'package:ui_temarlije/features/administrator/academic_year/screens/academic_year_screens.dart';
import 'package:ui_temarlije/features/administrator/school_members/all_members/members.dart';
import 'package:ui_temarlije/features/administrator/school_members/create_membership/members.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/school_org_screen.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/all_teachers.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/detail/teacher_detail.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/enrollments.dart';
import 'package:ui_temarlije/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/login/login_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/pricipal_registration/pricipal_registration_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/signup/signup_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/account_selection/account_type.dart';
import 'package:ui_temarlije/features/authentication/screens/student_registration/student_registration_screen.dart';
import 'package:ui_temarlije/features/authentication/screens/teacher_registration/teacher_registration_screen.dart';
import 'package:ui_temarlije/features/membership/screens/membership_screen.dart';
import 'package:ui_temarlije/features/teachers/screens/attendance_tracking/attendance_tracking_screen.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/lesson_plan_detail_screen.dart';
import 'package:ui_temarlije/features/teachers/screens/lesson_planning/lesson_planning_screen.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/routes/routes_middilware.dart';
import 'package:ui_temarlije/views/screens/gradebook_screen.dart';
import 'package:ui_temarlije/bindings/app_bindings.dart';

class TemarLijeAppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: TemarLijeRoutes.signUp,
      page: () => SignupScreen(),
      binding: TemarLijeAppBindings(),
    ),
    GetPage(name: TemarLijeRoutes.userType, page: () => AccountTypeScreen()),
    // GetPage(name: TemarLijeRoutes.profStudnet, page: () => StudentFormScreen()),
    GetPage(
      name: TemarLijeRoutes.profStudnet,
      page: () => StudentRegistrationScreen(),
    ),
    GetPage(
      name: TemarLijeRoutes.profPricpial,
      page: () => PricipalRegistrationScreen(),
    ),
    GetPage(name: TemarLijeRoutes.school, page: () => SchoolOrgScreen()),

    GetPage(
      name: TemarLijeRoutes.lessonPlanDetail,
      page: () => const LessonPlanDetailScreen(),
      binding: LessonPlanDetailBinding(),
    ),
    GetPage(
      name: TemarLijeRoutes.toolAttendaceTrack,
      page: () => const AttendanceTrackingScreen(),
      binding: TemarLijeAppBindings(),
    ),
    GetPage(
      name: TemarLijeRoutes.membershipRequests,
      page: () => const AllMembersScreen(),
    ),
    //AllMembersScreen
    GetPage(
      name: TemarLijeRoutes.createMembers,
      page: () => const CreateMembersScreen(),
    ),

    /// Teachers Pages and Routes
    GetPage(
      name: TemarLijeRoutes.schoolTeachers,
      page: () => const AllTeachers(),
    ),
    GetPage(
      name: TemarLijeRoutes.teacherDetails,
      page: () => const TeacherDetailScreen(),
    ),
    GetPage(
      name: TemarLijeRoutes.teacherProfile,
      page: () => const TeacherRegistrationScreen(),
    ),

    GetPage(
      name: TemarLijeRoutes.teachersEnrollments,
      page: () => const TeachersEnrollmentsList(),
    ),
    GetPage(
      name: TemarLijeRoutes.yearsAC,
      page: () => const AcademicYearScreens(),
    ),

    // GetPage(
    //   name: TemarLijeRoutes.membershipRequests,
    //   page: () => const SchoolMembershipRequestsScreen(),
    // ),
    // GetPage(
    //   name: TemarLijeRoutes.editMembers,
    //   page: () => const SchoolMembershipEditScreen(),
    // ),
    GetPage(
      name: TemarLijeRoutes.schoolUserJoin,
      page: () => const SchoolMembershipScreen(),
    ),
    GetPage(name: TemarLijeRoutes.markListPage, page: () => GradebookScreen()),
    GetPage(
      name: TemarLijeRoutes.logIn,
      page: () => LoginScreen(),
      binding: TemarLijeAppBindings(),
    ),

    GetPage(
      name: TemarLijeRoutes.logIn,
      page: () => LoginScreen(),
      binding: TemarLijeAppBindings(),
    ),
    GetPage(
      name: TemarLijeRoutes.dashbord,
      page: () => DashboardScreen(),
      middlewares: [TemarLijeRouteMiddlware()],
    ),
    GetPage(
      name: TemarLijeRoutes.resetPassword,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: TemarLijeRoutes.forgetPassword,
      page: () => ForgetPasswordScreen(),
    ),
    GetPage(
      name: TemarLijeRoutes.toolLessonPlaner,
      page: () => const LessonPlanningScreen(),
    ),
  ];
}
