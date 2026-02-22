import 'package:flutter/material.dart';

import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widget/theme_color_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.themeColorProvider});
  final ThemeColorProvider themeColorProvider;

  @override
  Widget build(BuildContext context) {
    final currentThemeColor = themeColorProvider.currentThemeColor;
    return Container(
      color: currentThemeColor.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            "Settings",
            style: AppTextStyles.heading.copyWith(
              color: currentThemeColor.color,
            ),
          ),

          SizedBox(height: 50),

          Text(
            "Theme",
            style: AppTextStyles.label.copyWith(color: AppColors.textLight),
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ThemeColor.values
                .map(
                  (theme) => ThemeColorButton(
                    themeColor: theme,
                    isSelected: theme == currentThemeColor,
                    onTap: (value) {
                      themeColorProvider.setThemeColor(value); //triggers rebuild
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
