import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';

class HelpMenuItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isRed;

  const HelpMenuItem({
    super.key,
    required this.title,
    required this.route,
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
                color: isRed ? AppColors.redAccent : AppColors.white,
                fontFamily: AppFontStyles.urbanistFontFamily,
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
