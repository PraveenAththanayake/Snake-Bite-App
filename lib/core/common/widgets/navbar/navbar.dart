import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';
import 'package:snake_bite_app/features/history/history.dart';
import 'package:snake_bite_app/features/home/home.dart';
import 'package:snake_bite_app/features/settings/settings.dart';
import 'package:snake_bite_app/features/support/support.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const HistoryScreen(),
      const SupportScreen(),
      const SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(LucideIcons.home),
        title: "Home",
        activeColorPrimary: ColorPalettes.accent,
        inactiveColorPrimary: ColorPalettes.accent.withOpacity(0.5),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(LucideIcons.history),
        title: "History",
        activeColorPrimary: ColorPalettes.accent,
        inactiveColorPrimary: ColorPalettes.accent.withOpacity(0.5),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(LucideIcons.helpCircle),
        title: "Support",
        activeColorPrimary: ColorPalettes.accent,
        inactiveColorPrimary: ColorPalettes.accent.withOpacity(0.5),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(LucideIcons.settings),
        title: "Settings",
        activeColorPrimary: ColorPalettes.accent,
        inactiveColorPrimary: ColorPalettes.accent.withOpacity(0.5),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardAppears: true,
          padding: const EdgeInsets.only(top: 8),
          backgroundColor: ColorPalettes.primary,
          navBarStyle: NavBarStyle.style19,
          animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
              animateTabTransition: true,
              duration: Duration(milliseconds: 200),
              screenTransitionAnimationType:
                  ScreenTransitionAnimationType.fadeIn,
            ),
          ),
        ),
      ),
    );
  }
}
