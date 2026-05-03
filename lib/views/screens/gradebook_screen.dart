import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_temarlije/model/student.dart';
import 'package:ui_temarlije/model/column_config.dart';
import 'package:ui_temarlije/providers/table_provider.dart';
import 'package:ui_temarlije/views/widgets/editable_mark_cell.dart';

class GradebookScreen extends ConsumerStatefulWidget {
  const GradebookScreen({super.key});

  @override
  ConsumerState<GradebookScreen> createState() => _GradebookScreenState();
}

class _GradebookScreenState extends ConsumerState<GradebookScreen> {
  final TextEditingController _newColumnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tableAsync = ref.watch(tableProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Interactive Gradebook'),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(tableProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          Expanded(
            child: tableAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (tableState) => _buildDataTable(tableState),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    final notifier = ref.read(tableProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _newColumnController,
              decoration: InputDecoration(
                hintText: 'New column name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: () => _addColumn(notifier),
            icon: const Icon(Icons.add),
            label: const Text('Add Column'),
          ),
          const SizedBox(width: 12),
          Consumer(
            builder: (context, ref, _) {
              final tableState = ref.watch(tableProvider).asData?.value;
              if (tableState == null || tableState.columns.isEmpty)
                return const SizedBox.shrink();
              return PopupMenuButton<String>(
                icon: const Icon(Icons.remove_circle_outline),
                tooltip: 'Remove Column',
                onSelected: (colName) =>
                    _confirmRemoveColumn(notifier, colName),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: '_header',
                    enabled: false,
                    child: Text(
                      'Select column to remove',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const PopupMenuDivider(),
                  ...tableState.columns.map(
                    (col) =>
                        PopupMenuItem(value: col.name, child: Text(col.name)),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Widget _buildDataTable(TableState tableState) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.vertical,
  //       child: DataTable(
  //         columnSpacing: 20,
  //         horizontalMargin: 16,
  //         headingRowColor: WidgetStateProperty.resolveWith(
  //           (states) => Colors.grey[100],
  //         ),
  //         columns: [
  //           const DataColumn(
  //             label: Text(
  //               'Student',
  //               style: TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           ...tableState.columns.map(
  //             (col) => DataColumn(label: Text(col.name)),
  //           ),
  //         ],
  //         rows: tableState.students.map((student) {
  //           return DataRow(
  //             cells: [
  //               DataCell(
  //                 Text(
  //                   student.name,
  //                   style: const TextStyle(fontWeight: FontWeight.w500),
  //                 ),
  //               ),
  //               ...tableState.columns.map((col) {
  //                 final mark = student.marks[col.name] ?? '';
  //                 return DataCell(
  //                   EditableMarkCell(
  //                     key: ValueKey('${student.id}_${col.name}'),
  //                     studentId: student.id,
  //                     columnName: col.name,
  //                     initialValue: mark,
  //                     onMarkChanged: (value) {
  //                       ref
  //                           .read(tableProvider.notifier)
  //                           .updateMark(student.id, col.name, value);
  //                     },
  //                   ),
  //                 );
  //               }),
  //             ],
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildDataTable(TableState tableState) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columnSpacing: 20,
          horizontalMargin: 16,
          headingRowColor: WidgetStateProperty.resolveWith(
            (states) => Colors.grey[100],
          ),
          columns: [
            const DataColumn(
              label: Text(
                'Student',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ...tableState.columns.map(
              (col) => DataColumn(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(col.name),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(
                        Icons.save,
                        size: 18,
                        color: Colors.blue,
                      ),
                      onPressed: () => _saveColumnMarks(col.name),
                      tooltip: 'Save all marks in ${col.name}',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          ],
          rows: tableState.students.map((student) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    student.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                ...tableState.columns.map((col) {
                  final mark = student.marks[col.name] ?? '';
                  return DataCell(
                    EditableMarkCell(
                      key: ValueKey('${student.id}_${col.name}'),
                      studentId: student.id,
                      columnName: col.name,
                      initialValue: mark,
                      onMarkChanged: (value) {
                        ref
                            .read(tableProvider.notifier)
                            .updateMark(student.id, col.name, value);
                      },
                    ),
                  );
                }),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  void _saveColumnMarks(String columnName) {
    final notifier = ref.read(tableProvider.notifier);
    final tableState = ref.read(tableProvider).asData?.value;
    if (tableState == null) return;

    final marksMap = <String, String>{};
    for (var student in tableState.students) {
      marksMap[student.id] = student.marks[columnName] ?? '';
    }
    notifier.bulkUpdateColumn(columnName, marksMap);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved all marks for "$columnName"')),
    );
  }

  void _addColumn(TableNotifier notifier) {
    if (_newColumnController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a column name')),
      );
      return;
    }
    notifier.addColumn(_newColumnController.text);
    _newColumnController.clear();
  }

  void _confirmRemoveColumn(TableNotifier notifier, String columnName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Column'),
        content: Text('Remove "$columnName"? All marks will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              notifier.removeColumn(columnName);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
