class TemarLijeRoutes {
  static const siteRoot = '/';
  static const dashbord = '/dahsboard';
  static const userType = '/u-type';

  static const logIn = '/login';
  static const signUp = '/signup';
  static const markListPage = '/mark-list';
  static const profStudnet = '/student';
  static const profPricpial = '/pricipal';

  static const forgetPassword = '/forget-password';
  static const resetPassword = '/reset-password/:email';
  static const classes = '/student-management/classes';
  // teacher Route
  static const toolLessonPlaner = '/tools/lesson-planer';
  static const toolAttendaceTrack = '/tools/attendace';
  static const toolAttendaceTrack2 = '/tools/attendace2';
  static const lessonPlanDetail = '/tools/lesson-plan-detail';
  static const joinTeacher = '/schoolJoin/teacer';
  static const school = '/school';
  static const schoolMembership = '/membeship/list';
  static const memberships = '/memberships';
  static const membershipById = '/memberships/';
  static const updateMembershipStatus = '/memberships/';

  // ORGINZATION MEMBESHIP
  static const allMembers = '/members/all-members';
  static const membershipRequests = '/members/join-requests';
  static const editMembers = '/members/edit';
  static const createMembers = '/members/create';
  // END OF ORGINZATION MEMBESHIP

  // USER's ROUTE
  static const schoolTeachers = '/teacher-management/all-teachers';
  static const teacherDetails = '/teachers/details';
  static const teacherProfile = '/teachers/new';
  //  Student  Routes
  static const schoolStudentKG = '/student-management/all-kg-student';
  static const schoolStudentAll = '/student-management/all-student';

  static const studentEnrollments = '/student-management/enrollments';
  static const studentEnrollmentDetails =
      '/student-management/enrollments/details';
  // Teacers Routes
  static const teachersEnrollments = '/teacher-management/enrollments';

  static const subjects = '/academics/subjects';

  static const schoolUserAll = '/users/all-users';
  static const schoolUserJoin = '/users/join-requests';
  static const schoolUserRolesPermissions = '/users/roles';
  // END OF USER's ROUTE
  static const myProfile = '/me';
  static const principals = '/principals';
  static const principalDetail = '/principal-detail';
  static const principalForm = '/principal-form';

  static const yearsAC = '/academics/years';
  static List sidebarMenuItems = [dashbord, markListPage];
}
