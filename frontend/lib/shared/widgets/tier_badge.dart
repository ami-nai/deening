import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import '../../core/constants/app_constants.dart';

class TierBadge extends StatelessWidget {
  final int tierIndex;
  final bool showName;

  const TierBadge({
    required this.tierIndex,
    this.showName = true,
    Key? key,
  }) : super(key: key);

  Color _getTierColor(int index) {
    switch (index) {
      case 0:
        return AppColors.tierBeginner;
      case 1:
        return AppColors.tierRegular;
      case 2:
        return AppColors.tierMuntazim;
      case 3:
        return AppColors.tierEnthusiast;
      case 4:
        return AppColors.tierMaster;
      default:
        return AppColors.grey400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getTierColor(tierIndex);
    final tierName = tierIndex < AppConstants.tierNames.length
        ? AppConstants.tierNames[tierIndex]
        : 'Unknown';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        showName ? tierName : '${AppConstants.tierThresholds[tierIndex]}',
        style: TextStyles.labelSmall.copyWith(color: color),
      ),
    );
  }
}
