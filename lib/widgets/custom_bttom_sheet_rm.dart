import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';
import 'package:flutterapp1/cubit/reminder time&mode/reminder_mode_cubit.dart';
import 'package:flutterapp1/cubit/reminder time&mode/reminder_mode_state.dart';
import 'package:flutterapp1/cubit/reminder time&mode/reminder_time_cubit.dart';
import 'package:flutterapp1/widgets/custom_bottom_sheet_interval.dart';

class ReminderBottomSheet extends StatelessWidget {
  const ReminderBottomSheet(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReminderTimeCubit(),
      child: BlocListener<ReminderCubit, ReminderState>(
        listenWhen:
            (previous, current) =>
                previous.steadySipReminder != current.steadySipReminder,
        listener: (context, state) {
          if (state.steadySipReminder) {
            // Open ReminderTimeBottomSheet when turned ON
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => IntervalBottomSheet(),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(30.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimensions.radius_30.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.reminderMode,
                    style: TextStyle(
                      fontFamily: AppFontStyles.urbanistFontFamily,
                      fontSize: AppFontStyles.fontSize_24.sp,
                      fontVariations: [
                        FontVariation(
                          'wght',
                          AppFontStyles.fontWeightVariation600.value,
                        ),
                      ],
                      color: AppColors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: AppFontStyles.fontSize_22.sp,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.dim20.h),

              // AI-Driven Smart Reminder
              BlocBuilder<ReminderCubit, ReminderState>(
                builder: (context, state) {
                  return _ReminderOptionCard(
                    title: AppStrings.aiDrivenSmartReminder,
                    subtitle: AppStrings.predictiveHydration,
                    features: const [
                      AppStrings.adaptsToYourScheduleWeatherAndActivity,
                      AppStrings.syncsWithGoogleCalender,
                      AppStrings.smartSnoozeAndPersonalizedTips,
                    ],
                    isActive: state.aiReminder,
                    onToggle:
                        (value) => context
                            .read<ReminderCubit>()
                            .toggleAiReminder(value),
                    activeColor: AppColors.white,
                    activeTrackColor: AppColors.violetBlue,
                  );
                },
              ),
              SizedBox(height: 16.h),

              // Steady Sip Reminder
              BlocBuilder<ReminderCubit, ReminderState>(
                builder: (context, state) {
                  return _ReminderOptionCard(
                    title: AppStrings.steadySipReminder,
                    features: const [
                      AppStrings.fixedIntervals,
                      AppStrings.simpleHydrationAlerts,
                    ],
                    isActive: state.steadySipReminder,
                    onToggle:
                        (value) => context
                            .read<ReminderCubit>()
                            .toggleSteadySipReminder(value),
                    activeColor: AppColors.white,
                    activeTrackColor: AppColors.violetBlue,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReminderOptionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<String> features;
  final bool isActive;
  final ValueChanged<bool> onToggle;
  final Color activeColor;
  final Color activeTrackColor;

  const _ReminderOptionCard({
    required this.title,
    this.subtitle,
    required this.features,
    required this.isActive,
    required this.onToggle,
    required this.activeColor,
    required this.activeTrackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.dim16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radius_16.r),
        color:
            isActive
                ? AppColors
                    .mulledWine // active background
                : AppColors.violapurple90, // inactive background
        border: Border.all(
          color: AppColors.nextButtonColor,
          width:
              isActive
                  ? AppDimensions.dim2.w
                  : AppDimensions.dim1.w, // active/inactive border width
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: AppFontStyles.urbanistFontFamily,
                      fontSize: AppFontStyles.fontSize_16.sp,
                      fontVariations: [
                        FontVariation(
                          'wght',
                          AppFontStyles.fontWeightVariation600.value,
                        ),
                      ],
                      color: AppColors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontFamily: AppFontStyles.urbanistFontFamily,
                        fontSize: AppFontStyles.fontSize_14.sp,
                        fontVariations: [
                          FontVariation(
                            'wght',
                            AppFontStyles.fontWeightVariation600.value,
                          ),
                        ],
                        color: AppColors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                ],
              ),
              Switch(
                value: isActive,
                onChanged: onToggle, // changes only toggle state
                activeColor: activeColor,
                activeTrackColor: activeTrackColor,
              ),
            ],
          ),

          Divider(color: AppColors.white46, thickness: 1.5),
          SizedBox(height: AppDimensions.dim12.h),

          // Features
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                features
                    .map(
                      (f) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimensions.dim6.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: AppColors.white70,
                              size: AppFontStyles.fontSize_16.sp,
                            ),
                            SizedBox(width: AppDimensions.dim9.w),
                            Expanded(
                              child: Text(
                                f,
                                style: TextStyle(
                                  fontFamily: AppFontStyles.urbanistFontFamily,
                                  fontSize: AppFontStyles.fontSize_14.sp,
                                  fontVariations: [
                                    FontVariation(
                                      'wght',
                                      AppFontStyles
                                          .fontWeightVariation600
                                          .value,
                                    ),
                                  ],
                                  color: AppColors.white,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
