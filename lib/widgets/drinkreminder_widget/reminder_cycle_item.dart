import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';

class ReminderCycleItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const ReminderCycleItem({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radius_12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.dim10.w,
          vertical: AppDimensions.dim10.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.white,
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
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.dim10.w,
                vertical: AppDimensions.dim3.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.greenwhite20,
                border: Border.all(
                  color: AppColors.white,
                  width: AppDimensions.dim1.w,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.radius_30.r),
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppFontStyles.fontSize_16.sp,
                  fontFamily: AppFontStyles.urbanistFontFamily,
                  fontVariations: [
                    FontVariation(
                      'wght',
                      AppFontStyles.semiBoldFontVariation.value,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
