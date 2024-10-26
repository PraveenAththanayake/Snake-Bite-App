import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/common/widgets/navbar/navbar.dart';
import 'package:snake_bite_app/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeMode,
      home: const Navbar(),
    );
  }
}
