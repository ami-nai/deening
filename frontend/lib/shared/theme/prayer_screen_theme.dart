import 'package:flutter/material.dart';

class PrayerScreenTheme {
  // Fazr Prayer Screen
  static const PrayerGradient fazr = PrayerGradient(
    beginColor: Color(0xFFFFFFFF),
    beginAlpha: 0.70,
    middleColor: Color(0xFFF6DAAE),
    endColor: Color(0xFF1E6A7A),
    textColor: Color(0xFFFFFEFE),
    assetPath: 'assets/images/fazr_sun.svg',
    iconWidthRatio: 0.25,
    iconHeightRatio: 0.125,
  );

  // Zuhr Prayer Screen
  static const PrayerGradient zuhr = PrayerGradient(
    beginColor: Color(0xFFFFFFFF),
    beginAlpha: 0.70,
    middleColor: Color(0xFFEDCC29),
    endColor: Color(0xFFF4CE67),
    textColor: Color(0xFF000000),
    assetPath: 'assets/images/zuhr_sun.svg',
    iconWidthRatio: 0.25,
    iconHeightRatio: 0.25,
  );

  // Asr Prayer Screen
  static const PrayerGradient asr = PrayerGradient(
    beginColor: Color(0xFFEDA229),
    beginAlpha: 1.0,
    middleColor: Color(0xFFFF9D3C),
    endColor: Color(0xFF7EA100),
    textColor: Color(0xFFFFFFFF),
    assetPath: 'assets/images/asr_sun.svg',
    iconWidthRatio: 0.25,
    iconHeightRatio: 0.25,
  );

  // Maghrib Prayer Screen
  static const PrayerGradient maghrib = PrayerGradient(
    beginColor: Color(0xB2F09FB6),
    beginAlpha: 1.0,
    middleColor: Color(0xFFFF7B25),
    endColor: Color(0xFF15082B),
    textColor: Color(0xFFFFFFFF),
    assetPath: 'assets/images/maghrib_sun.svg',
    iconWidthRatio: 0.25,
    iconHeightRatio: 0.125,
  );

  // Isha Prayer Screen
  static const PrayerGradient isha = PrayerGradient(
    beginColor: Color(0xFF200F40),
    beginAlpha: 1.0,
    middleColor: Color(0xFF0F0520),
    endColor: Color(0xFF000000),
    textColor: Color(0xFFFFFFFF),
    assetPath: 'assets/images/isha_moon.svg',
    iconWidthRatio: 0.20,
    iconHeightRatio: 0.20,
    hasStars: true,
  );

  // Common styling
  static const double textSizeRatio = 0.08;
  static const double textBottomOffsetRatio = 0.15;
  static const double letterSpacing = 1.0;
  static const String fontFamily = 'Inter';
  static const FontWeight fontWeight = FontWeight.w300;

  // Gradient alignment
  static const Alignment gradientBegin = Alignment(0.50, -0.31);
  static const Alignment gradientEnd = Alignment(0.50, 1.10);

  // Shadow
  static const Color shadowColor = Color(0x3F000000);
  static const double shadowBlur = 4.0;
  static const Offset shadowOffset = Offset(0, 4);
}

class PrayerGradient {
  final Color beginColor;
  final double beginAlpha;
  final Color middleColor;
  final Color endColor;
  final Color textColor;
  final String assetPath;
  final double iconWidthRatio;
  final double iconHeightRatio;
  final bool hasStars;

  const PrayerGradient({
    required this.beginColor,
    required this.beginAlpha,
    required this.middleColor,
    required this.endColor,
    required this.textColor,
    required this.assetPath,
    required this.iconWidthRatio,
    required this.iconHeightRatio,
    this.hasStars = false,
  });

  List<Color> get colors => [
    beginColor.withValues(alpha: beginAlpha),
    middleColor,
    endColor,
  ];
}
