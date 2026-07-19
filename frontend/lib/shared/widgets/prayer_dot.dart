import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PrayerDot extends StatelessWidget {
  final bool isLogged;
  final bool isGlowing;
  final VoidCallback? onTap;
  final double size;

  const PrayerDot({
    required this.isLogged,
    this.isGlowing = false,
    this.onTap,
    this.size = 48,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isLogged ? AppColors.primary : AppColors.grey200,
          boxShadow: isGlowing
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: isLogged
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: 24,
                ),
              )
            : null,
      ),
    );
  }
}
