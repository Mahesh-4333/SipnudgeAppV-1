import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';

class ToggleTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const ToggleTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        SwitchTheme(
          data: SwitchThemeData(
            thumbColor: WidgetStateProperty.all(AppColors.white),
            trackColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.violetBlue;
              }
              return AppColors.tuna;
            }),
            trackOutlineColor: WidgetStateProperty.all(
              Colors.white,
            ), // 👈 White border
            trackOutlineWidth: WidgetStateProperty.all(
              1.5,
            ), // 👈 Border thickness
            splashRadius: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Switch(value: value, onChanged: onChanged),
        ),
      ],
    );
  }
}
