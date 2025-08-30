import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool isRed;
  final VoidCallback onTap;

  const ProfileMenuItemWidget({
    super.key,
    required this.iconPath,
    required this.title,
    this.isRed = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLogout = title == AppStrings.logout;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.dim16.w,
          vertical: AppDimensions.dim12.h,
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 22.w,
              height: 22.h,
              color: isLogout ? AppColors.redAccent : AppColors.white,
              errorBuilder:
                  (_, __, ___) => Icon(
                    Icons.error,
                    color: AppColors.redAccent,
                    size: AppFontStyles.fontSize_22.sp,
                  ),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                color: isRed ? AppColors.redAccent : AppColors.white,
                fontFamily: AppFontStyles.urbanistFontFamily,
                fontVariations: [
                  FontVariation(
                    'wght',
                    AppFontStyles.semiBoldFontVariation.value,
                  ),
                ],
                fontSize: AppFontStyles.fontSize_18.sp,
              ),
            ),
            const Spacer(),
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
