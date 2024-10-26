import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snake_bite_app/core/common/widgets/appbar/appbar.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/animated_button.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'History',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: ColorPalettes.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  LucideIcons.file,
                  color: ColorPalettes.primary,
                  size: 80,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: AnimatedButton(
                text: 'Search by date or status',
                icon: LucideIcons.arrowRightCircle,
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 30),
            ..._buildHistoryCards(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHistoryCards() {
    return [
      _buildCard(
        text: 'Date',
        desc: '12/12/2021',
        icon: LucideIcons.calendar,
      ),
      _buildCard(
        text: 'Type of case',
        desc: 'Venomous',
        icon: LucideIcons.alertCircle,
      ),
      _buildCard(
        text: 'Snake Type',
        desc: 'Cobra',
        icon: LucideIcons.zap,
      ),
      _buildCard(
        text: 'Status',
        desc: 'Pending',
        icon: LucideIcons.clock,
      ),
      _buildCard(
        text: 'Symptoms',
        desc: 'Swelling, Pain',
        icon: LucideIcons.heart,
      ),
      _buildCard(
        text: 'Recommendation',
        desc: 'See a doctor',
        icon: LucideIcons.stethoscope,
      ),
      _buildCard(
        text: 'Photo',
        desc: 'View',
        icon: LucideIcons.image,
      ),
    ]
        .map((card) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: card,
            ))
        .toList();
  }

  Widget _buildCard({
    required String text,
    required String desc,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorPalettes.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorPalettes.primary,
            size: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
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
