import 'package:flutter/material.dart';
import 'package:ui_temarlije/data/models/student_enrollment.dart';

class StudentProfileCard extends StatelessWidget {
  final StudentEnrollmentWithDetails student;
  final VoidCallback? onDetailPressed;

  const StudentProfileCard({
    super.key,
    required this.student,
    this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        margin: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardHeader(student: student),
                const SizedBox(height: 20),
                Divider(color: Colors.grey.shade100, height: 1),
                const SizedBox(height: 20),
                _CardMetrics(experience: student.studentPhone.toString()),
                const SizedBox(height: 24),
                _CardActionButton(onPressed: onDetailPressed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 4. SUB-WIDGET: HEADER
class _CardHeader extends StatelessWidget {
  final StudentEnrollmentWithDetails student;

  const _CardHeader({required this.student});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Image Container with fallback initials
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blueAccent.shade100.withAlpha(20),
          foregroundImage: const NetworkImage(
            'http://localhost:8000/photo_2025-09-15_17-22-37.jpg',
          ),
          child: const Text(
            'AW',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
        // CircleAvatar(
        //   radius: 26,
        //   backgroundColor: Colors.blueAccent.shade100.withOpacity(0.2),
        //   foregroundImage: student.imageUrl != null ? NetworkImage(student.imageUrl!) : null,
        //   child: Text(
        //     student.initials,
        //     style: const TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //       color: Color(0xFF1E293B),
        //     ),
        //   ),
        // ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                student.studentName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                student.studentFirstName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent.shade700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _StatusBadge(isActive: true, text: student.enrollmentStatus.toString()),
      ],
    );
  }
}

/// 5. SUB-WIDGET: STATUS BADGE
class _StatusBadge extends StatelessWidget {
  final String text;
  final bool isActive;

  const _StatusBadge({required this.text, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final baseColor = isActive ? Colors.greenAccent : Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: baseColor.withAlpha(20),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: baseColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: baseColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// 6. SUB-WIDGET: METRICS / METADATA ROW
class _CardMetrics extends StatelessWidget {
  final String experience;

  const _CardMetrics({required this.experience});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.business_center_outlined,
          size: 20,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 8),
        Text(
          'Experience:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          experience,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}

/// 7. SUB-WIDGET: BUTTON ACTION
class _CardActionButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _CardActionButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: onPressed ?? () {},
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF0F172A),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'View Full Profile',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.arrow_forward, size: 16),
          ],
        ),
      ),
    );
  }
}
