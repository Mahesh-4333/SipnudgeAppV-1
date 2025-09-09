import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';

class SupportButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final String iconpatharrow;
  final VoidCallback onPressed;
  final Color? iconColor;

  const SupportButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.iconpatharrow,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.dim60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radius_100.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
            offset: Offset(AppDimensions.radius_4.r, AppDimensions.radius_4.r),
            blurRadius: AppDimensions.radius_4.r,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.dim10,
            vertical: AppDimensions.dim14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.r),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 12.w),
            Image.asset(iconPath, width: 24.w, height: 24.w, color: iconColor),
            SizedBox(width: 18.w),
            Text(
              label,
              style: TextStyle(
                color: AppColors.raisinblack,
                fontSize: AppFontStyles.fontSize_18,
                fontFamily: AppFontStyles.urbanistFontFamily,
                fontVariations: [
                  FontVariation(
                    'wght',
                    AppFontStyles.fontWeightVariation600.value,
                  ),
                ],
                // fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Image.asset(
              iconpatharrow,
              color: AppColors.black,
              width: AppDimensions.dim9.w,
              height: AppDimensions.dim16.h,
              //size: AppFontStyles.fontSize_24,
            ),
            SizedBox(width: AppDimensions.dim12.w),
          ],
        ),
      ),
    );
  }
}
