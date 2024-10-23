import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_bite_app/features/history/history.dart';
import 'package:snake_bite_app/features/home/home.dart';
import 'package:snake_bite_app/features/settings/settings.dart';
import 'package:snake_bite_app/features/support/support.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            HomeScreen(),
            HistoryScreen(),
            SupportScreen(),
            SettingsScreen()
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(
              selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad,
            );
          },
          selectedIndex: selectedIndex,
          barItems: [
            BarItem(
              filledIcon: Icons.home_rounded,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
              filledIcon: Icons.history_rounded,
              outlinedIcon: Icons.history_outlined,
            ),
            BarItem(
              filledIcon: Icons.support_rounded,
              outlinedIcon: Icons.support_outlined,
            ),
            BarItem(
              filledIcon: Icons.settings_rounded,
              outlinedIcon: Icons.settings_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
