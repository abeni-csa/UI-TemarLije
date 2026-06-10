import 'package:flutter/material.dart';

import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/pricipal_registration/responsive_screens/pricipal_registration_desktop_tablet.dart';
import 'package:ui_temarlije/features/authentication/screens/pricipal_registration/responsive_screens/pricipal_registration_mobile.dart';

class PricipalRegistrationScreen extends StatelessWidget {
  const PricipalRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijeSiteTemplate(
      useLayout: false,
      desktop: PricipalRegistrationDesktopTablet(),
      tablet: PricipalRegistrationDesktopTablet(),
      mobile: PricipalRegistrationMobile(),
    );
  }
}

// class PrincipalDashboardScreen extends StatelessWidget {
//   const PrincipalDashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<PrincipalController>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Principal Dashboard'),
//         centerTitle: true,
//         actions: [
//           Obx(
//             () => IconButton(
//               onPressed: controller.isSyncing.value
//                   ? null
//                   : controller.syncWithServer,
//               icon: Obx(
//                 () => controller.isSyncing.value
//                     ? const SizedBox(
//                         width: 24,
//                         height: 24,
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       )
//                     : const Icon(Iconsax.send),
//               ),
//               tooltip: 'Sync with server',
//             ),
//           ),
//         ],
//       ),
//       body: Obx(
//         () => RefreshIndicator(
//           onRefresh: () => controller.fetchAllPrincipals(refresh: true),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Current Principal Info
//                 if (controller.currentPrincipal.value != null)
//                   PrincipalInfoCard(
//                     principal: controller.currentPrincipal.value!,
//                   ),

//                 const SizedBox(height: 24),

//                 // Statistics Row
//                 Row(
//                   children: [
//                     Expanded(
//                       child: PrincipalStatsCard(
//                         title: 'Total Principals',
//                         value: controller.principals.length.toString(),
//                         icon: Iconsax.profile_2user,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: PrincipalStatsCard(
//                         title: 'Active',
//                         value: controller.principals
//                             .where((p) => p.canManageUsers)
//                             .length
//                             .toString(),
//                         icon: Iconsax.verify,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 24),

//                 // Quick Actions
//                 const Text(
//                   'Quick Actions',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildQuickActionCard(
//                         icon: Iconsax.add,
//                         label: 'Add Principal',
//                         color: Colors.blue,
//                         onTap: () => Get.to(() => PrincipalFormScreen()),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _buildQuickActionCard(
//                         icon: Iconsax.search_normal,
//                         label: 'View All',
//                         color: Colors.purple,
//                         onTap: () => Get.to(() => const PrincipalListScreen()),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _buildQuickActionCard(
//                         icon: Iconsax.refresh,
//                         label: 'Sync',
//                         color: Colors.orange,
//                         onTap: controller.syncWithServer,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 24),

//                 // Recent Principals Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Recent Principals',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () =>
//                           Get.to(() => const PrincipalListScreen()),
//                       child: const Text('View All'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),

//                 if (controller.isLoading.value && controller.principals.isEmpty)
//                   const Center(child: CircularProgressIndicator())
//                 else if (controller.principals.isEmpty)
//                   _buildEmptyState()
//                 else
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: controller.principals.length > 5
//                         ? 5
//                         : controller.principals.length,
//                     itemBuilder: (context, index) {
//                       final principal = controller.principals[index];
//                       return _buildRecentPrincipalTile(principal);
//                     },
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickActionCard({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 28, color: color),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: color,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRecentPrincipalTile(PrincipalModel principal) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.blue.shade100,
//           child: Text(
//             principal.firstName[0].toUpperCase(),
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//         ),
//         title: Text(principal.fullName),
//         subtitle: Text(principal.staffId),
//         trailing: const Icon(Iconsax.arrow_right_3, size: 16),
//         onTap: () => _showPrincipalDetails(principal),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 40),
//       child: Column(
//         children: [
//           Icon(Iconsax.profile_2user, size: 64, color: Colors.grey[400]),
//           const SizedBox(height: 16),
//           Text(
//             'No principals found',
//             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//           ),
//           const SizedBox(height: 8),
//           ElevatedButton(
//             onPressed: () => Get.to(() => PrincipalFormScreen()),
//             child: const Text('Add Your First Principal'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showPrincipalDetails(PrincipalModel principal) {
//     Get.bottomSheet(
//       Container(
//         padding: const EdgeInsets.all(20),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.blue.shade100,
//                   child: Text(
//                     principal.firstName[0].toUpperCase(),
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         principal.fullName,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         principal.staffId,
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       const SizedBox(height: 4),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.green.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           principal.staffType.name,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Divider(),
//             const SizedBox(height: 8),
//             _buildDetailRow(
//               Iconsax.calendar,
//               'Date of Birth',
//               principal.dateOfBirth,
//             ),
//             _buildDetailRow(
//               Iconsax.building,
//               'Department',
//               principal.department,
//             ),
//             _buildDetailRow(Iconsax.briefcase, 'Position', principal.position),
//             _buildDetailRow(
//               Iconsax.location,
//               'Address',
//               principal.addressInfo.city,
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     onPressed: () =>
//                         Get.to(() => PrincipalFormScreen(principal: principal)),
//                     icon: const Icon(Iconsax.edit),
//                     label: const Text('Edit'),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () => Get.back(),
//                     icon: const Icon(Iconsax.close_circle),
//                     label: const Text('Close'),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: Colors.grey[600]),
//           const SizedBox(width: 12),
//           SizedBox(
//             width: 100,
//             child: Text(label, style: TextStyle(color: Colors.grey[600])),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
