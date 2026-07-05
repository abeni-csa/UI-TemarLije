import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/data_table/table_action.dart';
import 'package:ui_temarlije/common/widgets/images/t_rounded_image.dart';
import 'package:ui_temarlije/features/administrator/school_members/all_members/widgets/edit_membership_form.dart';
import 'package:ui_temarlije/features/family_relation/family_relation_controllers.dart';
import 'package:ui_temarlije/features/membership/membership_controllers.dart';
import 'package:ui_temarlije/routes/routes.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/enums.dart';
import 'package:ui_temarlije/utils/constants/image_strings.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class AllMembersDataSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final Controller = MembershipControllers.instance;

    return DataRow2(
      cells: [
        // TO display table wihte image
        // DataCell(
        //   Row(
        //     children: [
        //       TemarLijeRoundedImage(
        //         imageType: ImageType.asset,
        //         padding: TemarLijeSizes.sm,
        //         width: 50,
        //         height: 50,
        //         image: TemarLijeImagesStrings.userProfileImage3,
        //         borderRadius: TemarLijeSizes.borderRadiusMd,
        //         backgroundColor: TemarLijeColors.primaryBackground,
        //       ),
        //       const SizedBox(width: TemarLijeSizes.spaceBtwItems),
        //       Expanded(
        //         child: Text(
        //           "Some Data",
        //           style: Theme.of(
        //             Get.context!,
        //           ).textTheme.bodyLarge!.apply(color: TemarLijeColors.primary),
        //           maxLines: 2,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        DataCell(
          Text("TemarLijeRoundedImage", overflow: TextOverflow.ellipsis),
        ),
        DataCell(
          Text("TemarLijeRoundedImage2", overflow: TextOverflow.ellipsis),
        ),
        DataCell(
          Text("TemarLijeRoundedImage3", overflow: TextOverflow.ellipsis),
        ),
        DataCell(
          Text("TemarLijeRoundedImage4", overflow: TextOverflow.ellipsis),
        ),
        DataCell(
          Text("TemarLijeRoundedImage5", overflow: TextOverflow.ellipsis),
        ),
        DataCell(
          Text("TemarLijeRoundedImage8", overflow: TextOverflow.ellipsis),
        ),
        DataCell(
          TemarLijeTableActionButtons(
            onEditPressed: () =>
                // Get.toNamed(TemarLijeRoutes.editMembers, arguments: "Catagory"),
                EditMembershipForm(),
            onDeletePressed: () => {print("Testing")},
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => 200000000000000;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => 0;
}
