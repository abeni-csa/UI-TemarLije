import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/data/repositories/school_organzation_repository.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/widgets/school_org_form.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/widgets/school_org_list.dart';
import 'package:ui_temarlije/service/school_orginzation_service.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SchoolMembershipView extends StatefulWidget {
  const SchoolMembershipView({super.key});

  @override
  State<SchoolMembershipView> createState() => _MembershipViewState();
}

/// View model for school organization management
/// Handles offline-first CRUD operations with sync support

class _MembershipViewState extends State<SchoolMembershipView> {
  final SchoolOrganzationRepository _repository = SchoolOrganzationRepository();
  final SchoolOrganizationService _schoolService = SchoolOrganizationService();
  List<SchoolOrganzationModel> _schoolOrganizations = [];
  bool _isLoading = false;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _loadSchools();
  }

  /// Loads schools from local database
  Future<void> _loadSchools() async {
    setState(() => _isLoading = true);
    try {
      final schools = await _repository.getAllSchools();
      setState(() {
        _schoolOrganizations = schools;
        _isLoading = false;
      });

      // Background sync with remote
      // _syncInBackground();
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Failed to load schools: $e');
    }
  }

  /// Creates a new school organization
  /// First saves to remote, then saves response to local database
  Future<void> _createSchoolOrg(CreateSchoolOrganzationRequest request) async {
    try {
      // Step 1: Save to remote server first
      final createdSchool = await _schoolService.createSchoolOrg(request);

      // Step 2: Save the returned server response to local database
      await _repository.saveSchoolOrgFromRemote(createdSchool);
      await _loadSchools();
      if (mounted) {
        _showSuccess('School organization created successfully!');
      }
    } catch (e) {
      debugPrint('Create school error: $e');
      _showError('Failed to create school: $e');
    }
  }

  /// Updates an existing school organization
  /// First updates remote, then updates local database with server response
  Future<void> _updateSchoolOrg(
    String id,
    UpdateSchoolOrganzationRequest request,
  ) async {
    try {
      // Step 1: Update remote server first
      final updatedSchool = await _schoolService.updateSchoolOrg(id, request);

      // Step 2: Update local database with server response
      // if (updatedSchool != null) {
      if (1 == 1) {
        await _repository.updateSchoolOrgFromRemote(updatedSchool);
        await _loadSchools();
        if (mounted) {
          _showSuccess('School organization updated successfully!');
        }
      }
    } catch (e) {
      debugPrint('Update school error: $e');
      _showError('Failed to update school: $e');
    }
  }

  /// Deletes a school organization
  /// First deletes from remote, then deletes from local database if remote successful
  Future<void> _deleteSchoolOrg(SchoolOrganzationModel school) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: TemarLijeColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete School Organization'),
        content: Text('Are you sure you want to delete "${school.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.facebookBackgroundColor,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: TemarLijeColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        // Step 1: Delete from remote server first
        await _schoolService.deleteSchoolOrg(school.id.toString());

        // Step 2: Delete from local database only after remote deletion succeeds
        await _repository.deleteSchoolOrg(school.id.toString());
        await _loadSchools();
        if (mounted) {
          _showSuccess('School organization deleted successfully!');
        }
      } catch (e) {
        _showError('Failed to delete school: $e');
      }
    }
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => SchoolOrgFormDialog(
        onSubmit: (request) async {
          await _createSchoolOrg(request);
        },
      ),
    );
  }

  void _showEditDialog(SchoolOrganzationModel school) {
    showDialog(
      context: context,
      builder: (context) => SchoolOrgFormDialog(
        schoolOrganization: school,
        onSubmitUpdate: (id, request) async {
          await _updateSchoolOrg(id, request);
        },
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: TemarLijeColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, overflow: TextOverflow.ellipsis),
        backgroundColor: TemarLijeColors.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isSyncing)
          const LinearProgressIndicator(
            backgroundColor: TemarLijeColors.accent,
          ),
        SchoolOrgList(
          schoolOrg: _schoolOrganizations,
          isLoading: _isLoading,
          onRefresh: _loadSchools,
          onDelete: _deleteSchoolOrg,
          onEdit: _showEditDialog,
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            backgroundColor: TemarLijeColors.facebookBackgroundColor,
            onPressed: _showCreateDialog,
            mini: true,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
