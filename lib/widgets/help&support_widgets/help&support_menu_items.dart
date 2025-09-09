import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';

class HelpMenuItem extends StatelessWidget {
  final String title;
  final String route;
  final String iconPathArrow;
  final bool isRed;

  const HelpMenuItem({
    super.key,
    required this.title,
    required this.route,
    required this.iconPathArrow,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.dim16.w,
          vertical: AppDimensions.dim12.h,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: AppFontStyles.fontSize_20.sp,
                fontFamily: AppFontStyles.urbanistFontFamily,
                fontVariations: [AppFontStyles.fontWeightVariation600],
              ),
            ),
            const Spacer(),
            Image.asset(
              iconPathArrow,
              color: AppColors.white,
              width: AppDimensions.dim9.w,
              height: AppDimensions.dim16.h,
            ),
            SizedBox(width: AppDimensions.dim8.w),
          ],
        ),
      ),
    );
  }
}
