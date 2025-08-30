import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';

class MenuItemTile extends StatelessWidget {
  final String title;
  final String info;

  const MenuItemTile({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => debugPrint("Tapped $title"),
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
                fontSize: AppFontStyles.fontSize_18.sp,
                fontFamily: AppFontStyles.urbanistFontFamily,
              ),
            ),
            const Spacer(),
            Text(
              info,
              style: TextStyle(
                color: AppColors.white,
                fontSize: AppFontStyles.fontSize_16.sp,
                fontFamily: AppFontStyles.urbanistFontFamily,
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
