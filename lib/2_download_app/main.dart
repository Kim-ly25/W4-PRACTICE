import 'package:flutter/material.dart';

import 'ui/providers/theme_color_provider.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'ui/screens/downloads/downloads_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 1;
  final ThemeColorProvider _themeColorProvider = ThemeColorProvider();

  @override
  void initState() {
    super.initState();
    _themeColorProvider.addListener((){   //rebuild when theme changes
      setState(() {
      });
    });
  }

  @override
  void dispose(){
    _themeColorProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = _themeColorProvider.currentThemeColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        body: _currentIndex == 0
            ? DownloadsScreen(themeColor:theme)
            : SettingsScreen(themeColorProvider: _themeColorProvider),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: theme.color,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Downloads'),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
