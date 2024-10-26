import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class SnakeTypeCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SnakeTypeCard({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          _buildImageCard(),
          const SizedBox(height: 16),
          _buildTextCard(),
        ],
      ),
    );
  }

  Widget _buildImageCard() {
    return Container(
      height: 160,
      width: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isSelected
              ? (text == 'Non-Venomous'
                  ? [
                      Colors.green.withOpacity(0.8),
                      Colors.greenAccent.withOpacity(0.8)
                    ]
                  : [
                      Colors.red.withOpacity(0.8),
                      Colors.redAccent.withOpacity(0.8)
                    ])
              : [
                  ColorPalettes.primary.withOpacity(0.8),
                  ColorPalettes.secondary.withOpacity(0.8)
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextCard() {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? (text == 'Non-Venomous' ? Colors.green : Colors.red)
            : ColorPalettes.background,
        border: Border.all(
          color: ColorPalettes.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : ColorPalettes.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
