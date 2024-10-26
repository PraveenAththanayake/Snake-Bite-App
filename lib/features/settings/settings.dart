import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/common/widgets/appbar/appbar.dart';
import 'package:snake_bite_app/features/settings/widgets/app_settings.dart';
import 'package:snake_bite_app/features/settings/widgets/app_version.dart';
import 'package:snake_bite_app/features/settings/widgets/notification_switch.dart';
import 'package:snake_bite_app/features/settings/widgets/profile.dart';
import 'package:snake_bite_app/features/settings/widgets/support_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Settings'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileSection(),
            SizedBox(height: 30),
            AppSettingsSection(),
            SizedBox(height: 30),
            SupportSection(),
            SizedBox(height: 20),
            NotificationSwitch(),
            SizedBox(height: 20),
            AppVersion(),
          ],
        ),
      ),
    );
  }
}
