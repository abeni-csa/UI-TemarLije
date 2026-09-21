import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/data_table/paginated_data_table.dart';
import 'package:ui_temarlije/features/administrator/teacher_management/enrollments/table/table_sorce.dart';

class TeachersEnrollmentDataTable extends StatelessWidget {
  const TeachersEnrollmentDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijePaginatedDataTable(
      // minWidth: 1200,
      columns: const [
        // pub id: Uuid,
        // pub base_user_id: Uuid,
        // pub first_name: String,
        // pub middle_name: Option<String>,
        // pub last_name: String,
        // pub date_of_birth: NaiveDate,
        // pub teacher_id: String,
        // pub qualification: String,
        // pub specialization: Vec<String>,
        // pub years_of_experience: i32,
        // pub hire_date: Option<DateTime<Utc>>,
        // pub employment_type: EmploymentType,
        // pub is_homeroom_teacher: bool,
        // pub phone_number: String,
        // pub gender: String,
        // pub address_info: Json<AddressInfo>,
        // pub created_at: DateTime<Utc>,
        // pub updated_at: DateTime<Utc>,
        // // Membership fields
        // pub membership_id: Uuid,
        // pub membership_status: SchoolMembershipStatus,
        // pub joined_acadmic_year_id: Option<Uuid>,
        // pub membership_type: UserType,
        DataColumn2(label: Text("Full Name"), fixedWidth: 200),
        DataColumn2(label: Text("Qualification")),
        DataColumn2(label: Text("Phone No")),
        DataColumn2(label: Text("Gender")),
        DataColumn2(label: Text("Status")),
        DataColumn2(label: Text("Action"), fixedWidth: 100),
      ],
      source: TeachersEnrollmentDataTableSource(),
    );
  }
}
