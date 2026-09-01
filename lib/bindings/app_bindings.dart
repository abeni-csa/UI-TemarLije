import 'package:get/get.dart';
import 'package:ui_temarlije/common/widgets/layouts/sidebar/sidebar_controller.dart';
import 'package:ui_temarlije/data/repositories/authentication_repository.dart';
import 'package:ui_temarlije/data/repositories/teacher_repository.dart';
import 'package:ui_temarlije/data/repositories/user_repository.dart';
import 'package:ui_temarlije/features/administrator/academic_year/academic_year_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/kg/kg_students_controller.dart';
import 'package:ui_temarlije/features/administrator/classroom/classroom_controller.dart';
import 'package:ui_temarlije/features/administrator/school_org/global_school_controller.dart';
import 'package:ui_temarlije/features/administrator/school_org/school_org_controller.dart';
import 'package:ui_temarlije/features/administrator/student_management/enrollments/enrollments_controller.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/all_teacher_controller.dart';
import 'package:ui_temarlije/features/authentication/controllers/login_controller.dart';
import 'package:ui_temarlije/features/authentication/controllers/principal_controller.dart';
import 'package:ui_temarlije/features/authentication/controllers/signup_controller.dart';
import 'package:ui_temarlije/features/authentication/controllers/student_registration_controller.dart';
import 'package:ui_temarlije/features/membership/membership_controllers.dart';
import 'package:ui_temarlije/service/academic_year_service.dart';
import 'package:ui_temarlije/service/classroom_sections_service.dart';
import 'package:ui_temarlije/service/student_enrollment_service.dart';
import 'package:ui_temarlije/service/student_service.dart';
import 'package:ui_temarlije/service/subject_service.dart';
import 'package:ui_temarlije/service/teacher_service.dart';
import 'package:ui_temarlije/service/teachers_enrollment_service.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:ui_temarlije/service/school_orginzation_service.dart';

/// Dependency injection bindings for authentication modules
/// Registers all required dependencies before they're used
class TemarLijeAppBindings extends Bindings {
  @override
  void dependencies() {
    // Core network dependencies (lazy-loaded to improve startup time)
    Get.lazyPut<DioClient>(() => DioClient(), fenix: true);
    // Get.lazyPut<NetworkManager>(() => NetworkManager(), fenix: true);

    Get.lazyPut(() => SubjectService());
    Get.lazyPut<TeacherService>(() => TeacherService(), fenix: true);
    Get.lazyPut<AllTeacherController>(
      () => AllTeacherController(),
      fenix: true,
    );
    Get.put(GlobalSchoolController());

    Get.lazyPut<SchoolOrgController>(() => SchoolOrgController());
    Get.lazyPut<SidebarController>(
      () => SidebarController(),
    ); // Repository layer
    Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);

    Get.lazyPut<UsersRepository>(() => UsersRepository(), fenix: true);

    // Controller layer
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<PrincipalController>(() => PrincipalController(), fenix: true);
    Get.lazyPut<TeacherRepository>(
      () => TeacherRepository.instance,
      fenix: true,
    );
    Get.lazyPut<TeachersEnrollmentService>(
      () => TeachersEnrollmentService(),
      fenix: true,
    );
    // Register AcademicYearService
    if (!Get.isRegistered<AcademicYearService>()) {
      Get.put(AcademicYearService(), permanent: true);
    }

    // Register AcademicYearController
    Get.put(AcademicYearController(), permanent: true);
    Get.lazyPut<MembershipControllers>(
      () => MembershipControllers(),
      fenix: true,
    );

    Get.lazyPut<StudentRegistrationController>(
      () => StudentRegistrationController(),
      fenix: true,
    );
    Get.lazyPut<StudentEnrollmentsController>(
      () => StudentEnrollmentsController(),
    );
    Get.lazyPut<SchoolOrganizationService>(
      () => SchoolOrganizationService(),

      fenix: true,
    );
    Get.lazyPut<SignupController>(() => SignupController(), fenix: true);
    Get.put(GlobalSchoolController());
    Get.lazyPut<ClassroomController>(() => ClassroomController());

    Get.put<StudentService>(StudentService());
    Get.lazyPut<KGStudentsController>(() => KGStudentsController());
    Get.lazyPut<StudentEnrollmentService>(() => StudentEnrollmentService());
    Get.lazyPut<ClassroomService>(() => ClassroomService());
  }
}
