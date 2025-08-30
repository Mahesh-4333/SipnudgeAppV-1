// widgets/menu_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String info;
  final VoidCallback? onTap;
  final bool isRed;

  const MenuItem({
    super.key,
    required this.title,
    required this.info,
    this.onTap,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.dim16,
          vertical: AppDimensions.dim12,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isRed ? AppColors.redAccent : AppColors.white,
                fontFamily: AppFontStyles.urbanistFontFamily,
                fontSize: AppFontStyles.fontSize_18.sp,
              ),
            ),
            const Spacer(),
            Text(
              info,
              style: TextStyle(
                color: isRed ? AppColors.redAccent : AppColors.white,
                fontFamily: AppFontStyles.urbanistFontFamily,
                fontSize: AppFontStyles.fontSize_16.sp,
              ),
            ),
            SizedBox(width: AppDimensions.dim15.w),
            Icon(
              Icons.chevron_right,
              color: AppColors.white,
              size: AppFontStyles.fontSize_24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
