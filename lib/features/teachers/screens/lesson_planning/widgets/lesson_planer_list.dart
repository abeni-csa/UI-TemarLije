// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:ui_temarlije/common/widgets/card/dashboard_card.dart';
// import 'package:ui_temarlije/data/models/lesson_plans.dart';
// import 'package:ui_temarlije/data/repositories/lesson_planning_repository.dart';
// import 'package:ui_temarlije/utils/constants/sizes.dart';

// class LessoPlanerList extends StatelessWidget {
//   const LessoPlanerList({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Lesson Planner",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: TemarLijeSizes.spaceBtwItems),

//             // Use Expanded or flexible layouts for responsive cards
//             const SizedBox(height: TemarLijeSizes.spaceBtwItems),
//             ElevatedButton.icon(
//               onPressed: () => print("Buton Pressed"),
//               icon: const Icon(Icons.add),
//               label: const Text('Create New Lesson Plan'),
//             ),
//             const SizedBox(height: TemarLijeSizes.spaceBtwItems * 2),

//             Row(
//               children: [
//                 TemarLijeDashboardCard(
//                   title: "Students",
//                   value: "2,500",
//                   percentage: "+0.5%",
//                   isPositive: true,
//                   icon: Iconsax.people,
//                 ),
//                 TemarLijeDashboardCard(
//                   title: "Teachers",
//                   value: "46",
//                   percentage: "-10%",
//                   isPositive: false,
//                   icon: Iconsax.unlimited,
//                 ),
//                 TemarLijeDashboardCard(
//                   title: "Staff",
//                   value: "9",
//                   percentage: "+10%",
//                   isPositive: true,
//                   icon: Iconsax.shopping_cart,
//                 ),
//               ],
//             ),

//             const SizedBox(height: TemarLijeSizes.spaceBtwItems),

//             NoteListScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NoteListScreen extends StatefulWidget {
//   const NoteListScreen({Key? key}) : super(key: key);

//   @override
//   State<NoteListScreen> createState() => _NoteListScreenState();
// }

// class _NoteListScreenState extends State<NoteListScreen> {
//   final LessonPlanningRepository _repository = LessonPlanningRepository();
//   List<LessonPlan> _notes = [];
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadNotes();
//   }

//   Future<void> _loadNotes() async {
//     setState(() => _isLoading = true);
//     try {
//       final notes = await _repository.getAllLessonPlans();
//       setState(() {
//         _notes = notes;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() => _isLoading = false);
//       _showError('Failed to load notes: $e');
//     }
//   }

//   Future<void> _addNote() async {
//     final lessonPlan = LessonPlan.create(
//       title: 'New Note',
//       subject: 'Start writing your thoughts...',
//       gradeLevel: 'Start writing your thoughts...',
//       durationMinutes: 45,
//     );
//     try {
//       await _repository.createLessonPlan(lessonPlan);
//       _loadNotes();
//     } catch (e) {
//       _showError('Failed to create note: $e');
//     }
//   }

//   Future<void> _deleteNote(LessonPlan lessonPlan) async {
//     try {
//       await _repository.deleteLessonPlan(lessonPlan.id);
//       _loadNotes();
//     } catch (e) {
//       _showError('Failed to delete note: $e');
//     }
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.black),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'My Notes',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.black),
//             onPressed: _loadNotes,
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator(color: Colors.black))
//           : _notes.isEmpty
//           ? const Center(
//               child: Text(
//                 'No notes yet.\nTap + to create your first one!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.black54, fontSize: 16),
//               ),
//             )
//           : ListView.separated(
//               padding: const EdgeInsets.all(16),
//               itemCount: _notes.length,
//               separatorBuilder: (_, __) => const Divider(color: Colors.black12),
//               itemBuilder: (context, index) {
//                 final note = _notes[index];
//                 return ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   title: Text(
//                     note.title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                   subtitle: Text(
//                     note.subject,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(color: Colors.black54),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(
//                       Icons.delete_outline,
//                       color: Colors.black54,
//                     ),
//                     onPressed: () => _deleteNote(note),
//                   ),
//                   onTap: () {
//                     // TODO: Navigate to detail screen
//                   },
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.black,
//         onPressed: _addNote,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/card/dashboard_card.dart';
import 'package:ui_temarlije/data/models/lesson_plans.dart';
import 'package:ui_temarlije/data/repositories/lesson_planning_repository.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class LessoPlanerList extends StatelessWidget {
  const LessoPlanerList({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lesson Planner",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),

            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            ElevatedButton.icon(
              onPressed: () => print("Buton Pressed"),
              icon: const Icon(Icons.add),
              label: const Text('Create New Lesson Plan'),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems * 2),

            Row(
              children: [
                TemarLijeDashboardCard(
                  title: "Students",
                  value: "2,500",
                  percentage: "+0.5%",
                  isPositive: true,
                  icon: Iconsax.people,
                ),
                TemarLijeDashboardCard(
                  title: "Teachers",
                  value: "46",
                  percentage: "-10%",
                  isPositive: false,
                  icon: Iconsax.unlimited,
                ),
                TemarLijeDashboardCard(
                  title: "Staff",
                  value: "9",
                  percentage: "+10%",
                  isPositive: true,
                  icon: Iconsax.shopping_cart,
                ),
              ],
            ),

            const SizedBox(height: TemarLijeSizes.spaceBtwItems),

            const NoteListScreen(),
          ],
        ),
      ),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final LessonPlanningRepository _repository = LessonPlanningRepository();
  List<LessonPlan> _notes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);
    try {
      final notes = await _repository.getAllLessonPlans();
      setState(() {
        _notes = notes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Failed to load notes: $e');
    }
  }

  Future<void> _addNote() async {
    final lessonPlan = LessonPlan.create(
      title: 'New Note',
      subject: 'Start writing your thoughts...',
      gradeLevel: 'Start writing your thoughts...',
      durationMinutes: 45,
    );
    try {
      await _repository.createLessonPlan(lessonPlan);
      _loadNotes();
    } catch (e) {
      _showError('Failed to create note: $e');
    }
  }

  Future<void> _deleteNote(LessonPlan lessonPlan) async {
    try {
      await _repository.deleteLessonPlan(lessonPlan.id);
      _loadNotes();
    } catch (e) {
      _showError('Failed to delete note: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Notes',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: _loadNotes,
            ),
          ],
        ),
        const SizedBox(height: TemarLijeSizes.spaceBtwItems),

        _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : _notes.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'No notes yet.\nTap + to create your first one!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: _notes.length,
                separatorBuilder: (_, __) =>
                    const Divider(color: Colors.black12),
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      note.subject,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.black54,
                      ),
                      onPressed: () => _deleteNote(note),
                    ),
                    onTap: () {
                      // TODO: Navigate to detail screen
                    },
                  );
                },
              ),

        const SizedBox(height: TemarLijeSizes.spaceBtwItems),

        Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: _addNote,
            mini: true,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
