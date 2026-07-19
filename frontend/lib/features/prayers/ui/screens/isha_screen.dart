import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/shared/theme/prayer_screen_theme.dart';
import 'dart:math';

class IshaScreen extends StatelessWidget {
  const IshaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = PrayerScreenTheme.isha;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.50, -0.00),
            end: const Alignment(0.50, 1.00),
            colors: [
              theme.beginColor,
              theme.endColor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: PrayerScreenTheme.shadowColor,
              blurRadius: PrayerScreenTheme.shadowBlur,
              offset: PrayerScreenTheme.shadowOffset,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Scattered Stars
            ..._generateStars(screenWidth, screenHeight),
            
            // Moon (centered)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * theme.iconWidthRatio,
                    height: screenWidth * theme.iconHeightRatio,
                    child: SvgPicture.asset(
                      theme.assetPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            
            // Isha Text (bottom)
            Positioned(
              left: 0,
              right: 0,
              bottom: screenHeight * PrayerScreenTheme.textBottomOffsetRatio,
              child: Center(
                child: Text(
                  'Isha',
                  style: TextStyle(
                    color: theme.textColor,
                    fontSize: screenWidth * PrayerScreenTheme.textSizeRatio,
                    fontFamily: PrayerScreenTheme.fontFamily,
                    fontWeight: PrayerScreenTheme.fontWeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateStars(double screenWidth, double screenHeight) {
    final random = Random(42); // Seeded for consistent positioning
    final stars = <Widget>[];
    
    // Generate 12 stars scattered across the screen
    for (int i = 0; i < 12; i++) {
      final left = random.nextDouble() * screenWidth;
      final top = random.nextDouble() * screenHeight * 0.7; // Concentrate in upper/middle area
      final size = random.nextDouble() * 8 + 4; // Size between 4-12
      
      stars.add(
        Positioned(
          left: left,
          top: top,
          child: Icon(
            Icons.star,
            color: Colors.white,
            size: size,
          ),
        ),
      );
    }
    
    return stars;
  }
}