import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? flexibleSpace;
  final double elevation;

  const CustomAppBar({
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.flexibleSpace,
    this.elevation = 4.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalettes.primary,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: elevation,
            offset: Offset(0, elevation / 2),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: ColorPalettes.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: centerTitle,
        actions: actions,
        leading: leading,
        flexibleSpace: flexibleSpace,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
