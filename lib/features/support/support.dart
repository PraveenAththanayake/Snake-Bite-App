import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snake_bite_app/core/common/widgets/appbar/appbar.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/custom_button.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Support'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need Assistance?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorPalettes.primary,
              ),
            ),
            const SizedBox(height: 20),

            // FAQs Section
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorPalettes.primary,
              ),
            ),
            const Divider(color: Colors.grey, height: 20),
            _buildFAQItem(
              context,
              question: 'How can I reset my password?',
              answer:
                  'To reset your password, go to the login page and click on "Forgot Password?"',
            ),
            _buildFAQItem(
              context,
              question: 'How do I contact support?',
              answer:
                  'You can contact support via email at support@example.com.',
            ),
            _buildFAQItem(
              context,
              question: 'Where can I find the terms of service?',
              answer:
                  'The terms of service can be found in the app settings under "Legal".',
            ),
            const SizedBox(height: 20),

            // Contact Support Section
            const Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorPalettes.primary,
              ),
            ),
            const Divider(color: Colors.grey, height: 20),
            const ListTile(
              leading: Icon(LucideIcons.mail, color: ColorPalettes.primary),
              title: Text('Email Us'),
              subtitle: Text('support@example.com'),
            ),
            const ListTile(
              leading: Icon(LucideIcons.phone, color: ColorPalettes.primary),
              title: Text('Call Us'),
              subtitle: Text('+1 234 567 890'),
            ),
            const SizedBox(height: 20),

            // Feedback Section
            const Text(
              'Feedback',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorPalettes.primary,
              ),
            ),
            const Divider(color: Colors.grey, height: 20),
            CustomButton(text: 'Give Feedback', onPressed: () {})
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context,
      {required String question, required String answer}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
