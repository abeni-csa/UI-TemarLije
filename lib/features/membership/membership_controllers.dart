import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/service/school_orginzation_service.dart';
import 'package:uuid/uuid.dart';

class MembershipControllers extends GetxController {
  static MembershipControllers get instance =>
      Get.find<MembershipControllers>();
  final SchoolOrganizationService _schoolOrganizationService =
      Get.find<SchoolOrganizationService>();

  final RxList<SchoolOrganzationModel> _schools =
      <SchoolOrganzationModel>[].obs;
  final RxList<Membership> _myMemberships = <Membership>[].obs;
  final RxList<Membership> _schoolMembers = <Membership>[].obs;
  final RxList<Membership> _pendingRequests = <Membership>[].obs;
  final RxBool _isLoading = false.obs;
  String? _error;

  List<SchoolOrganzationModel> get schools => _schools;
  List<Membership> get myMemberships => _myMemberships;
  List<Membership> get schoolMembers => _schoolMembers;
  List<Membership> get pendingRequests => _pendingRequests;
  RxBool get isLoading => _isLoading;
  String? get error => _error;

  void loadSchools() async {
    _isLoading.value = true;
    _error = null;

    try {
      var loadedSchools = await _schoolOrganizationService.getSchools();
      _schools.assignAll(loadedSchools);
      _isLoading.value = false;
    } catch (e) {
      _error = e.toString();
      _isLoading.value = false;
    }
  }

  Future<void> loadMyMemberships(String userId) async {
    _isLoading.value = true;

    try {
      _myMemberships.value = await _schoolOrganizationService
          .getUserMemberships(userId);
      _isLoading.value = false;
    } catch (e) {
      _error = e.toString();
      _isLoading.value = false;
    }
  }

  Future<void> joinSchoolAsStudent({
    required Uuid schoolId,
    required String userId,
    String? academicYearId,
  }) async {
    _isLoading.value = true;
    _error = null;
    try {
      await _schoolOrganizationService.joinSchoolAsStudent(schoolId: schoolId);
      await loadMyMemberships(userId);
      _isLoading.value = false;
    } catch (e) {
      _error = e.toString();
      _isLoading.value = false;
      rethrow;
    }
  }
  // Add this method to MembershipControllers class

  Future<void> joinSchoolWithData({
    required Uuid schoolId,
    required UserType membershipType,
    required Map<String, dynamic> additionalData,
  }) async {
    _isLoading.value = true;
    _error = null;
    try {
      // await _schoolOrganizationService.joinSchoolWithData(
      //   schoolId: schoolId,
      //   membershipType: membershipType,
      //   additionalData: additionalData,
      // );
      UnimplementedError;
      _isLoading.value = false;
    } catch (e) {
      _error = e.toString();
      _isLoading.value = false;
      rethrow;
    }
  }

  Future<void> joinSchoolAsTeacher({
    required Uuid schoolId,
    required String userId,
    String? academicYearId,
  }) async {
    _isLoading.value = true;
    _error = null;
    try {
      await _schoolOrganizationService.joinSchoolAsTeacher(
        schoolId: schoolId,
        userId: userId,
        academicYearId: academicYearId,
      );
      await loadMyMemberships(userId);
      _isLoading.value = false;
    } catch (e) {
      _error = e.toString();
      _isLoading.value = false;
      rethrow;
    }
  }

  Future<void> joinSchoolAsStaff({
    required Uuid schoolId,
    required String userId,
    String? academicYearId,
  }) async {
    _isLoading.value = true;
    _error = null;
    try {
      await _schoolOrganizationService.joinSchoolAsStaff(
        schoolId: schoolId,
        userId: userId,
        academicYearId: academicYearId,
      );
      await loadMyMemberships(userId);
      _isLoading.value = false;
    } catch (e) {
      _error = e.toString();
      _isLoading.value = false;
      rethrow;
    }
  }

  Future<void> joinSchool({
    required Uuid schoolId,
    required String userId,
    required UserType membershipType,
    String? academicYearId,
  }) async {
    switch (membershipType) {
      case UserType.Student:
        await joinSchoolAsStudent(
          schoolId: schoolId,
          userId: userId,
          academicYearId: academicYearId,
        );
        break;
      case UserType.Teacher:
        await joinSchoolAsTeacher(
          schoolId: schoolId,
          userId: userId,
          academicYearId: academicYearId,
        );
        break;
      case UserType.Librarian:
        await joinSchoolAsStaff(
          schoolId: schoolId,
          userId: userId,
          academicYearId: academicYearId,
        );
        break;
      default:
        break;
    }
  }

  Future<void> loadSchoolMembers(Uuid schoolId) async {
    _isLoading.value = true;
    try {
      _schoolMembers.value = await _schoolOrganizationService.getSchoolMembers(
        schoolId,
      );
      _isLoading.value = false;
    } catch (e) {
      _error = e.toString();
      _isLoading.value = false;
    }
  }

  Future<void> loadPendingRequests(Uuid schoolId) async {
    _isLoading.value = true;
    try {
      _pendingRequests.value = await _schoolOrganizationService
          .getPendingRequests(schoolId);
      _isLoading.value = false;
    } catch (e) {
      _error = e.toString();
      _isLoading.value = false;
    }
  }

  Future<void> updateRequestStatus({
    required Uuid schoolId,
    required MembershipStatus status,
    required List<String> userIds,
  }) async {
    _isLoading.value = true;
    try {
      await _schoolOrganizationService.updateMembershipStatus(
        schoolId: schoolId,
        status: status,
        userIds: userIds,
      );
      await loadPendingRequests(schoolId);
      await loadSchoolMembers(schoolId);
      _isLoading.value = false;
    } catch (e) {
      _error = e.toString();
      _isLoading.value = false;
      rethrow;
    }
  }

  void clearError() {
    _error = null;
  }

  @override
  void onInit() {
    loadSchools();
    super.onInit();
  }
}
