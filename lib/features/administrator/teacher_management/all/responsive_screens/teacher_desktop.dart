import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/common/widgets/data_table/table_header.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/all/table/data_table.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TeacherDesktopScreen extends StatelessWidget {
  const TeacherDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(TemarLijeSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TemarLijeBreadcrumbsWithHeading(
              heading: 'Product Details',
              breadcrumbsItems: ['/products', '/electronics', '/laptops'],
              returnToPreviousScreen: true,
            ),
            SizedBox(height: TemarLijeSizes.sm),
            // Table Body
            TemarLijeRoundedContainer(
              child: Column(
                children: [
                  TemarLijeDataTableHeader(
                    showLeftWidget: false,
                    onPress: () => {},
                  ),
                  SizedBox(height: TemarLijeSizes.sm),
                  AllTeachersDataTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
