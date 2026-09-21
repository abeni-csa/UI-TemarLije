import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/containers/rounded_container.dart';
import 'package:ui_temarlije/utils/device/device_utility.dart';

class EnrollmentStats extends StatelessWidget {
  final Map<String, dynamic> stats;
  final bool isLoading;

  const EnrollmentStats({
    super.key,
    required this.stats,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = TemarLijeDeviceUtils.isMobileScreen(context) ? 2 : 4;

    final isMobile = TemarLijeDeviceUtils.isMobileScreen(context);
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: isMobile ? 2.8 : 4.5,
      children: [
        _buildStatCard(
          'Total',
          stats['total']?.toString() ?? '0',
          Icons.people,
          Colors.blue,
        ),
        _buildStatCard(
          'Active',
          stats['active']?.toString() ?? '0',
          Icons.check_circle,
          Colors.green,
        ),
        _buildStatCard(
          'Withdrawn',
          stats['withdrawn']?.toString() ?? '0',
          Icons.cancel,
          Colors.red,
        ),
        _buildStatCard(
          'Transferred',
          stats['transferred']?.toString() ?? '0',
          Icons.swap_horiz,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return TemarLijeRoundedContainer(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(120),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withAlpha(30)),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                isLoading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        value,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
