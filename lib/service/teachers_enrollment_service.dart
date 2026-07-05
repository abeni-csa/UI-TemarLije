// // import 'package:get/get.dart';
// // import 'package:ui_temarlije/data/models/membeship.dart';
// // import 'package:ui_temarlije/service/network/dio_client.dart';
// // import 'package:uuid/uuid.dart';

// // class TeachersEnrollmentService extends GetxService {
// //   final DioClient _dioClient = Get.find<DioClient>();

// //   // Fetch pending enrollment requests
// //   Future<List<Membership>> getPendingRequests(String schoolId) async {
// //     try {
// //       final response = await _dioClient.get(
// //         '/org/school/$schoolId/members/pending-requests',
// //       );

// //       if (response.statusCode == 200) {
// //         final List<dynamic> data = response.data;
// //         return data.map((json) => Membership.fromJson(json)).toList();
// //       } else {
// //         throw Exception(
// //           'Failed to load pending requests: ${response.statusCode}',
// //         );
// //       }
// //     } catch (e) {
// //       throw Exception('Error fetching pending requests: $e');
// //     }
// //   }

// //   // Accept a single enrollment request
// //   Future<void> acceptRequest(String requestId, String academicYearId) async {
// //     try {
// //       final response = await _dioClient.post(
// //         '/org/school/members/$requestId/accept',
// //         data: {'academic_year_id': academicYearId},
// //       );

// //       if (response.statusCode != 200 && response.statusCode != 201) {
// //         throw Exception('Failed to accept request: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Error accepting request: $e');
// //     }
// //   }

// //   // Reject a single enrollment request
// //   Future<void> rejectRequest(String requestId) async {
// //     try {
// //       final response = await _dioClient.delete(
// //         '/org/school/members/$requestId',
// //       );

// //       if (response.statusCode != 200 && response.statusCode != 204) {
// //         throw Exception('Failed to reject request: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Error rejecting request: $e');
// //     }
// //   }

// //   // Batch accept requests
// //   Future<void> batchAcceptRequests(BatchMembershipRequest batchRequest) async {
// //     try {
// //       //http://127.0.0.1:57000/api/v1/org/school/015cb15a-86d8-7052-8376-15ec5d6bc8d3/members/pending-requests
// //       final response = await _dioClient.post(
// //         '/org/school/015cb15a-86d8-7052-8376-15ec5d6bc8d3/members/update-status',
// //         data: batchRequest.toJson(),
// //       );

// //       if (response.statusCode != 200 && response.statusCode != 201) {
// //         throw Exception(
// //           'Failed to batch accept requests: ${response.statusCode}',
// //         );
// //       }
// //     } catch (e) {
// //       throw Exception('Error batch accepting requests: $e');
// //     }
// //   }

// //   // Batch reject requests
// //   Future<void> batchRejectRequests(
// //     String schoolId,
// //     List<Uuid> requestIds,
// //   ) async {
// //     try {
// //       final response = await _dioClient.post(
// //         '/org/school/$schoolId/members/batch-reject',
// //         data: {'request_ids': requestIds},
// //       );

// //       if (response.statusCode != 200 && response.statusCode != 204) {
// //         throw Exception(
// //           'Failed to batch reject requests: ${response.statusCode}',
// //         );
// //       }
// //     } catch (e) {
// //       throw Exception('Error batch rejecting requests: $e');
// //     }
// //   }
// // }
// import 'package:get/get.dart';
// import 'package:ui_temarlije/data/models/membeship.dart';
// import 'package:ui_temarlije/service/network/dio_client.dart';
// import 'package:uuid/uuid.dart';

// class TeachersEnrollmentService extends GetxService {
//   final DioClient _dioClient = Get.find<DioClient>();

//   // Fetch pending enrollment requests
//   Future<List<Membership>> getPendingRequests(String schoolId) async {
//     try {
//       final response = await _dioClient.get(
//         '/org/school/$schoolId/members/pending-requests',
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => Membership.fromJson(json)).toList();
//       } else {
//         throw Exception(
//           'Failed to load pending requests: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       throw Exception('Error fetching pending requests: $e');
//     }
//   }

//   // Batch update membership status
//   Future<void> batchUpdateStatus({
//     required String schoolId,
//     required MembershipStatus status,
//     required List<Uuid> userIds,
//   }) async {
//     try {
//       // Convert status to the format expected by the backend
//       final String statusString = _mapStatusToString(status);

//       final response = await _dioClient.post(
//         '/org/school/$schoolId/update-status',
//         data: {
//           'status': statusString,
//           'user_ids': userIds.map((id) => id.toString()).toList(),
//         },
//       );

//       if (response.statusCode != 200 && response.statusCode != 201) {
//         throw Exception(
//           'Failed to update membership status: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       throw Exception('Error updating membership status: $e');
//     }
//   }

//   // Map enum to string expected by backend
//   String _mapStatusToString(MembershipStatus status) {
//     switch (status) {
//       case MembershipStatus.Active:
//         return 'active';
//       case MembershipStatus.Rejected:
//         return 'rejected';
//       case MembershipStatus.Pending:
//         return 'pending';
//       case MembershipStatus.Archived:
//         return 'archived';
//       case MembershipStatus.TransferdToOther:
//         return 'transferd_to_other';
//       case MembershipStatus.Promoted:
//         return 'promoted';
//     }
//   }

//   // Accept a single enrollment request (using the same batch endpoint)
//   Future<void> acceptRequest(
//     String schoolId,
//     String userId,
//     String academicYearId,
//   ) async {
//     try {
//       // If you need to pass academic year, you might need a different endpoint
//       // or modify the request structure. For now, we'll use the batch endpoint
//       // with a single user
//       await batchUpdateStatus(
//         schoolId: schoolId,
//         status: MembershipStatus.Active,
//         userIds: [Uuid.fromString(userId)],
//       );
//     } catch (e) {
//       throw Exception('Error accepting request: $e');
//     }
//   }

//   // Reject a single enrollment request
//   Future<void> rejectRequest(String schoolId, String userId) async {
//     try {
//       await batchUpdateStatus(
//         schoolId: schoolId,
//         status: MembershipStatus.Rejected,
//         userIds: [Uuid.fromString(userId)],
//       );
//     } catch (e) {
//       throw Exception('Error rejecting request: $e');
//     }
//   }

//   // Batch accept requests
//   Future<void> batchAcceptRequests(String schoolId, List<Uuid> userIds) async {
//     try {
//       await batchUpdateStatus(
//         schoolId: schoolId,
//         status: MembershipStatus.Active,
//         userIds: userIds,
//       );
//     } catch (e) {
//       throw Exception('Error batch accepting requests: $e');
//     }
//   }

//   // Batch reject requests
//   Future<void> batchRejectRequests(String schoolId, List<Uuid> userIds) async {
//     try {
//       await batchUpdateStatus(
//         schoolId: schoolId,
//         status: MembershipStatus.Rejected,
//         userIds: userIds,
//       );
//     } catch (e) {
//       throw Exception('Error batch rejecting requests: $e');
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:ui_temarlije/data/models/membeship.dart';
import 'package:ui_temarlije/service/network/dio_client.dart';
import 'package:uuid/uuid.dart';

class TeachersEnrollmentService extends GetxService {
  final DioClient _dioClient = Get.find<DioClient>();

  // Fetch pending enrollment requests
  Future<List<Membership>> getPendingRequests(dynamic schoolId) async {
    try {
      // http://127.0.0.1:57000/api/v1/org/school/015cb15a-86d8-7052-8376-15ec5d6bc8d3/members/pending-requests
      final response = await _dioClient.get(
        '/org/school/$schoolId/members/pending-requests',
      );
      print('Going To URL [+] ${(response.realUri.toString())} ');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print(data.toString());
        return data.map((json) => Membership.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load pending requests: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching pending requests: $e');
    }
  }

  // Batch update membership status
  Future<void> batchUpdateStatus({
    required String schoolId,
    required MembershipStatus status,
    required List<String> userIds, // Changed from List<Uuid> to List<String>
  }) async {
    try {
      // Convert status to the format expected by the backend
      final String statusString = _mapStatusToString(status);

      final response = await _dioClient.post(
        '/org/school/$schoolId/members/update-status',
        data: {
          'status': statusString,
          'user_ids': userIds, // Now passing as List<String> directly
        },
      );
      print('Going To URL [+] ${(response.realUri.toString())} ');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
          'Failed to update membership status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error updating membership status: $e');
    }
  }

  // Map enum to string expected by backend
  String _mapStatusToString(MembershipStatus status) {
    switch (status) {
      case MembershipStatus.Active:
        return 'Active';
      case MembershipStatus.Rejected:
        return 'Rejected';
      case MembershipStatus.Pending:
        return 'pending';
      case MembershipStatus.Archived:
        return 'archived';
      case MembershipStatus.TransferdToOther:
        return 'transferd_to_other';
      case MembershipStatus.Promoted:
        return 'promoted';
    }
  }

  // Accept a single enrollment request
  Future<void> acceptRequest(
    String schoolId,
    String userId,
    String academicYearId,
  ) async {
    try {
      await batchUpdateStatus(
        schoolId: schoolId,
        status: MembershipStatus.Active,
        userIds: [userId], // Pass the userId as String in a list
      );
    } catch (e) {
      throw Exception('Error accepting request: $e');
    }
  }

  // Reject a single enrollment request
  Future<void> rejectRequest(String schoolId, String userId) async {
    try {
      await batchUpdateStatus(
        schoolId: schoolId,
        status: MembershipStatus.Rejected,
        userIds: [userId],
      );
    } catch (e) {
      throw Exception('Error rejecting request: $e');
    }
  }

  // Batch accept requests
  Future<void> batchAcceptRequests(String schoolId, List<Uuid> userIds) async {
    try {
      // Convert Uuid list to String list
      final List<String> userIdStrings = userIds
          .map((id) => id.toString())
          .toList();

      await batchUpdateStatus(
        schoolId: schoolId,
        status: MembershipStatus.Active,
        userIds: userIdStrings,
      );
    } catch (e) {
      throw Exception('Error batch accepting requests: $e');
    }
  }

  // Batch reject requests
  Future<void> batchRejectRequests(String schoolId, List<Uuid> userIds) async {
    try {
      // Convert Uuid list to String list
      final List<String> userIdStrings = userIds
          .map((id) => id.toString())
          .toList();

      await batchUpdateStatus(
        schoolId: schoolId,
        status: MembershipStatus.Rejected,
        userIds: userIdStrings,
      );
    } catch (e) {
      throw Exception('Error batch rejecting requests: $e');
    }
  }
}
