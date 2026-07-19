import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/shared/theme/prayer_screen_theme.dart';

class FazrScreen extends StatelessWidget {
  const FazrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = PrayerScreenTheme.fazr;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: PrayerScreenTheme.gradientBegin,
            end: PrayerScreenTheme.gradientEnd,
            colors: theme.colors,
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
            // Loading Indicator (centered)
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
            // Fazr Text (bottom)
            Positioned(
              left: 0,
              right: 0,
              bottom: screenHeight * PrayerScreenTheme.textBottomOffsetRatio,
              child: Center(
                child: Text(
                  'Fazr',
                  style: TextStyle(
                    color: theme.textColor,
                    fontSize: screenWidth * PrayerScreenTheme.textSizeRatio,
                    fontFamily: PrayerScreenTheme.fontFamily,
                    fontWeight: PrayerScreenTheme.fontWeight,
                    letterSpacing: PrayerScreenTheme.letterSpacing,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
