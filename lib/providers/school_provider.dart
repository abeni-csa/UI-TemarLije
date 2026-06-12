import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/service/school_orginzation_service.dart';

class SchoolProvider extends ChangeNotifier {
  final SchoolOrganizationService _schoolApiService =
      SchoolOrganizationService();

  List<SchoolOrganzationModel> _schools = [];
  List<Membership> _myMemberships = [];
  List<Membership> _schoolMembers = [];
  List<Membership> _pendingRequests = [];
  bool _isLoading = false;
  String? _error;

  List<SchoolOrganzationModel> get schools => _schools;
  List<Membership> get myMemberships => _myMemberships;
  List<Membership> get schoolMembers => _schoolMembers;
  List<Membership> get pendingRequests => _pendingRequests;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadSchools() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _schools = await _schoolApiService.getSchools();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMyMemberships(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _myMemberships = await _schoolApiService.getUserMemberships(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> joinSchool({
    required String schoolId,
    required String userId,
    required UserType membershipType,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _schoolApiService.joinSchool(
        schoolId: schoolId,
        userId: userId,
        membershipType: membershipType,
      );
      await loadMyMemberships(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> loadSchoolMembers(String schoolId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _schoolMembers = await _schoolApiService.getSchoolMembers(schoolId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPendingRequests(String schoolId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _pendingRequests = await _schoolApiService.getPendingRequests(schoolId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateRequestStatus({
    required String schoolId,
    required MembershipStatus status,
    required List<String> userIds,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _schoolApiService.updateMembershipStatus(
        schoolId: schoolId,
        status: status,
        userIds: userIds,
      );
      await loadPendingRequests(schoolId);
      await loadSchoolMembers(schoolId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
