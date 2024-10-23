import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/common/widgets/navbar/navbar.dart';
import 'package:snake_bite_app/core/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeMode,
      home: Navbar(),
    );
  }
}
