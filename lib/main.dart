// Basic imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// UI
import 'package:dynamic_color/dynamic_color.dart';
import 'package:ug_mini_market/ui/screens/main_screen.dart';
import 'config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // Constants
  const MyApp({super.key});

  final double borderRadius = 12.0, cardElevation = 8.0;
  static const Color primaryColor = Color(0xFF6D98BA),
      secondaryColor = Color(0xFFC2F9BB),
      tertiaryColor = Color(0xFFE3D0D8);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? light, ColorScheme? dark) {
        ColorScheme lightColorScheme, darkColorScheme;
        UGMarketBackgroundTheme theme = const UGMarketBackgroundTheme();

        if (light != null && dark != null) {
          // We have both color schemes from the system itself
          lightColorScheme = light.harmonized().copyWith();
          lightColorScheme = lightColorScheme.copyWith(
            primary: theme.primaryColor,
            secondary: theme.secondaryColor,
            tertiary: theme.tertiaryColor,
          );
          darkColorScheme = dark.harmonized().copyWith();
          darkColorScheme = darkColorScheme.copyWith(
            primary: theme.primaryColor,
            secondary: theme.secondaryColor,
            tertiary: theme.tertiaryColor,
          );
        } else {
          // Use my own color scheme
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: theme.primaryColor,
            secondary: theme.secondaryColor,
            tertiary: theme.tertiaryColor,
            brightness: Brightness.light,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: theme.primaryColor,
            secondary: theme.secondaryColor,
            tertiary: theme.tertiaryColor,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: 'UG Market',
          theme: theme.toThemeData(colorScheme: lightColorScheme),
          initialRoute: "/",
          routes: {
            "/": (context) => MainScreen(),
          },
        );
      },
    );
  }
}
