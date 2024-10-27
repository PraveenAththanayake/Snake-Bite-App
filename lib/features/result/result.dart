import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snake_bite_app/core/common/widgets/appbar/appbar.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/animated_button.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/outline_button.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';
import 'package:snake_bite_app/features/result/widgets/snake_type_card.dart';
import 'package:snake_bite_app/features/result/widgets/symptom_checkbox.dart';

class ResultScreen extends StatefulWidget {
  final String predictedClass;
  const ResultScreen({super.key, required this.predictedClass});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with AutomaticKeepAliveClientMixin {
  final Map<String, bool> _symptoms = {
    'Swelling': false,
    'Pain': false,
    'Redness': false,
    'Nausea': false,
    'Vomiting': false,
  };

  String? _selectedSnakeType;

  @override
  bool get wantKeepAlive => true;

  void _addSymptom(String symptom) {
    if (symptom.isNotEmpty) {
      setState(() {
        _symptoms[symptom] = false;
      });
    }
  }

  Future<void> _showAddSymptomDialog() async {
    final TextEditingController symptomController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Add Symptom'),
              content: TextField(
                controller: symptomController,
                decoration: const InputDecoration(
                  hintText: 'Enter symptom name',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addSymptom(symptomController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );

    symptomController.dispose();
  }

  void _selectSnakeType(String snakeType) {
    setState(() {
      _selectedSnakeType = snakeType;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Snake Identification',
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.arrowLeft,
            color: ColorPalettes.accent,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SnakeTypeCard(
                  imagePath: 'assets/images/non-venomous.png',
                  text: 'Non-Venomous',
                  isSelected: _selectedSnakeType == 'Non-Venomous',
                  onTap: () => _selectSnakeType('Non-Venomous'),
                ),
                SnakeTypeCard(
                  imagePath: 'assets/images/venomous.png',
                  text: 'Venomous',
                  isSelected: _selectedSnakeType == 'Venomous',
                  onTap: () => _selectSnakeType('Venomous'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Add your symptoms here',
              style: TextStyle(
                fontSize: 18,
                color: ColorPalettes.primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: _symptoms.keys.map((symptom) {
                  return SymptomCheckbox(
                    symptomName: symptom,
                    value: _symptoms[symptom]!,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _symptoms[symptom] = newValue ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedButton(
              text: 'Add your own symptoms',
              icon: LucideIcons.plusCircle,
              onPressed: _showAddSymptomDialog,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlineButton(
                  text: 'View',
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                OutlineButton(
                  text: 'Medical Advice',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
