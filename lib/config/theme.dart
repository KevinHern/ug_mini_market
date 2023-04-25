// Basic Imports
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

@immutable
class UGMarketBackgroundTheme extends ThemeExtension<UGMarketBackgroundTheme> {
  final Color primaryColor, secondaryColor, tertiaryColor, neutralColor;
  const UGMarketBackgroundTheme({
    this.primaryColor = const Color(0xFF90C2E7),
    this.secondaryColor = const Color(0xFF966B9D),
    this.tertiaryColor = const Color(0xFF114B5F),
    this.neutralColor = const Color(0xFF72787e),
  });

  TextTheme _textTheme() => TextTheme();

  ThemeData toThemeData({ColorScheme? colorScheme}) => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: _textTheme(),
      );

  @override
  ThemeExtension<UGMarketBackgroundTheme> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? neutralColor,
  }) =>
      UGMarketBackgroundTheme(
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        tertiaryColor: tertiaryColor ?? this.tertiaryColor,
        neutralColor: neutralColor ?? this.neutralColor,
      );

  @override
  ThemeExtension<UGMarketBackgroundTheme> lerp(
      covariant ThemeExtension<UGMarketBackgroundTheme>? other, double t) {
    if (other is! UGMarketBackgroundTheme) return this;
    return UGMarketBackgroundTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
    );
  }
}
