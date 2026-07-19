import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double height;
  final ButtonStyle? style;
  final Widget? icon;
  final bool isOutlined;

  const CustomButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height = 48,
    this.style,
    this.icon,
    this.isOutlined = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidget = SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isEnabled && !isLoading ? onPressed : null,
              style: style,
              child: _buildChild(),
            )
          : ElevatedButton(
              onPressed: isEnabled && !isLoading ? onPressed : null,
              style: style,
              child: _buildChild(),
            ),
    );

    return buttonWidget;
  }

  Widget _buildChild() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(label),
        ],
      );
    }

    return Text(label);
  }
}
