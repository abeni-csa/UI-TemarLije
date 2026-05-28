class TemarLijeRoutes {
  static const siteRoot = '/';
  static const dashbord = '/dahsboard';
  static const userType = '/u-type';

  static const logIn = '/login';
  static const signUp = '/signup';
  static const markListPage = '/mark-list';
  static const profStudnet = '/student';

  static const forgetPassword = '/forget-password';
  static const resetPassword = '/reset-password/:email';

  // teacher Route
  static const toolLessonPlaner = '/tools/lesson-planer';
  static const toolAttendaceTrack = '/tools/attendace';
  static const lessonPlanDetail = '/tools/lesson-plan-detail';
  static const joinTeacher = '/schoolJoin/teacer';

  static const myProfile = '/me';
  static const principals = '/principals';
  static const principalDetail = '/principal-detail';
  static const principalForm = '/principal-form';
  static List sidebarMenuItems = [dashbord, markListPage];
}
