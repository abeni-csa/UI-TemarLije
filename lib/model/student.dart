class Student {
  final String id;
  final String name;

  Student({required this.id, required this.name});
}

class StudentWithMarks {
  final String id;
  final String name;
  final Map<String, String> marks;

  StudentWithMarks({required this.id, required this.name, required this.marks});
}
