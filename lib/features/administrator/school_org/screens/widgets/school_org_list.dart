import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/features/administrator/school_org/screens/widgets/school_org_card.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class SchoolOrgList extends StatelessWidget {
  final List<SchoolOrganzationModel> schoolOrg;
  final bool isLoading;
  final VoidCallback onRefresh;
  final Function(SchoolOrganzationModel) onDelete;
  final Function(SchoolOrganzationModel) onEdit;

  const SchoolOrgList({
    super.key,
    required this.schoolOrg,
    required this.isLoading,
    required this.onRefresh,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My School\'s',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              overflow: TextOverflow.fade,
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: onRefresh,
              tooltip: 'Refresh',
            ),
          ],
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),
        if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(color: Colors.black),
            ),
          )
        else if (schoolOrg.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No School yet',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your school\'s',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: schoolOrg.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final school = schoolOrg[index];
              return SchoolOrgCard(
                schoolOrganzation: school,
                onDelete: () => onDelete(school),
                onEdit: () => onEdit(school),
              );
            },
          ),
      ],
    );
  }
}
