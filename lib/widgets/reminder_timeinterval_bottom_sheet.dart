import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';

import '../cubit/reminder time&mode/reminder_cubit.dart';
import '../cubit/reminder time&mode/reminder_state.dart';

class ReminderBottomSheet extends StatelessWidget {
  const ReminderBottomSheet({super.key, required this.aiReminder, this.onSave});

  final bool aiReminder;
  final void Function(List<TimeOfDay> enabledTimes)? onSave;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(AppDimensions.radius_30.r);

    return FractionallySizedBox(
      heightFactor: 0.8, // 80% of screen height
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
            ),
          ),
          child: SafeArea(
            top: false,
            child: BlocBuilder<ReminderIntervalCubit, ReminderIntervalState>(
              builder: (context, state) {
                final cubit = context.read<ReminderIntervalCubit>();
                final entries = cubit.state.slots.entries.toList();

                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: AppDimensions.dim20.w,
                    right: AppDimensions.dim20.w,
                    top: AppDimensions.dim20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppStrings.reminderTime,
                              style: TextStyle(
                                fontFamily: AppFontStyles.urbanistFontFamily,
                                color: AppColors.white,
                                fontSize: AppFontStyles.fontSize_24.sp,
                                fontVariations: [
                                  FontVariation(
                                    'wght',
                                    AppFontStyles.fontWeightVariation600.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: AppColors.white,
                              size: AppFontStyles.fontSize_22.sp,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: AppDimensions.dim19.h),

                      /// Time slots
                      ...entries.map((e) {
                        final enabled = e.value;
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: AppDimensions.dim12.h,
                          ),
                          child: _TimeRow(
                            timeLabel: _formatAmPm(e.key),
                            value: enabled,
                            onChanged: (v) => cubit.toggle(e.key, v),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  static String _formatAmPm(String key) {
    final h = int.parse(key.substring(0, 2));
    final m = key.substring(3, 5);
    final period = h >= 12 ? 'PM' : 'AM';
    int h12 = h % 12;
    if (h12 == 0) h12 = 12;
    return '${h12.toString().padLeft(2, '0')}:$m $period';
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({
    required this.timeLabel,
    required this.value,
    required this.onChanged,
  });

  final String timeLabel;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.dim18.w,
        vertical: AppDimensions.dim12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.bottomSheetGradientStart,
        borderRadius: BorderRadius.circular(AppDimensions.radius_50.r),
        border: Border.all(
          color: AppColors.unSelectedPurpleToggle,
          width: AppDimensions.dim1.w,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(3.r, 4.r),
            color: AppColors.black40,
            blurRadius: 4.r,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            timeLabel,
            style: TextStyle(
              fontFamily: AppFontStyles.urbanistFontFamily,
              color: AppColors.white,
              fontSize: AppFontStyles.fontSize_20.sp,
              fontVariations: [
                FontVariation(
                  'wdgt',
                  AppFontStyles.fontWeightVariation600.value,
                ),
              ],
            ),
          ),
          const Spacer(),
          Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.resolveWith<Color>(
              (states) =>
                  AppColors.white, // same thumb color for active & inactive
            ),
            trackColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.lovelyPurple; // active track
              }
              return AppColors.lavenderPinocchio; // inactive track
            }),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
