class ColumnConfig {
  final String id;
  final String name;
  final String type; // 'mark', 'text', etc.

  ColumnConfig({required this.id, required this.name, required this.type});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'type': type};

  factory ColumnConfig.fromJson(Map<String, dynamic> json) {
    return ColumnConfig(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String? ?? 'mark',
    );
  }
}
