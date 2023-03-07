import 'package:flutter/material.dart';
import 'package:improsso/application/theme_service.dart';
import 'package:provider/provider.dart';

class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Switch Theme"),
          Switch(
              value: themeService.isDarkModeOn,
              onChanged: (value) {
                themeService.toogleTheme();
              }),
        ],
      );
    });
  }
}
