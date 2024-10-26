import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class SymptomCheckbox extends StatelessWidget {
  final String symptomName;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const SymptomCheckbox({
    Key? key,
    required this.symptomName,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: ColorPalettes.primary,
            ),
            Text(
              symptomName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
