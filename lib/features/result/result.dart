import 'dart:async'; // Import the async library for Timer
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

  Color _nonVenomousColor = Colors.grey;
  Color _venomousColor = Colors.grey;
  Timer? _timer;

  late TextEditingController _symptomController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _startBlinking();
    _symptomController = TextEditingController();
  }

  void _startBlinking() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        // Check if still mounted
        setState(() {
          if (widget.predictedClass == 'Non_Venomous') {
            _nonVenomousColor = _nonVenomousColor == Colors.green
                ? Colors.greenAccent.withOpacity(0.8)
                : Colors.green;
          } else if (widget.predictedClass == 'Venomous') {
            _venomousColor = _venomousColor == Colors.red
                ? Colors.redAccent.withOpacity(0.8)
                : Colors.red;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    _symptomController.dispose();
  }

  Future<void> _showAddSymptomDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Symptom'),
          content: TextField(
            controller: _symptomController,
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
                final symptomName = _symptomController.text.trim();
                if (symptomName.isNotEmpty) {
                  Navigator.of(context).pop();
                  _addSymptom(symptomName);
                  _symptomController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a symptom name.'),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addSymptom(String symptom) {
    if (mounted && symptom.isNotEmpty) {
      setState(() {
        _symptoms[symptom] = false;
      });
    }
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SnakeTypeCard(
                        imagePath: 'assets/images/non-venomous.png',
                        text: 'Non-Venomous',
                        color: widget.predictedClass == 'Non_Venomous'
                            ? _nonVenomousColor
                            : ColorPalettes.primary.withOpacity(0.8),
                      ),
                      SnakeTypeCard(
                        imagePath: 'assets/images/venomous.png',
                        text: 'Venomous',
                        color: widget.predictedClass == 'Venomous'
                            ? _venomousColor
                            : ColorPalettes.primary.withOpacity(0.8),
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
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                  const SizedBox(height: 20),
                  AnimatedButton(
                    text: 'Add Your Own Symptoms',
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
        },
      ),
    );
  }
}
