import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';

class ReminderToggleRow extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ReminderToggleRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.dim8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppFontStyles.fontSize_20.sp,
              fontFamily: AppFontStyles.urbanistFontFamily,
              fontVariations: [
                FontVariation(
                  'wght',
                  AppFontStyles.boldFontVariation.value,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.white,
            activeTrackColor: AppColors.violetBlue,
            inactiveTrackColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
