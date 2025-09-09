// reminder_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';
import 'package:flutterapp1/cubit/custom_bottom_sheet__reminder_mode/reminder_mode_bottomsheet_cubit.dart';
import 'package:flutterapp1/cubit/custom_bottom_sheet__reminder_mode/reminder_mode_bottomsheet_state.dart';
import 'package:flutterapp1/widgets/custom_bottom_sheet_interval.dart';
import 'package:flutterapp1/widgets/custom_reminder_mode_bottomsheet_widget/reminder_mode_bottomsheet_optionCard.dart';

class ReminderBottomSheet extends StatelessWidget {
  const ReminderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Reminder_Mode_BottonSheet_Cubit(),
      child: BlocListener<
        Reminder_Mode_BottonSheet_Cubit,
        Reminder_Mode_BottonSheet_State
      >(
        listenWhen:
            (previous, current) =>
                previous.steadySipReminder != current.steadySipReminder,
        listener: (context, state) {
          if (state.steadySipReminder) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const IntervalBottomSheet(),
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
              /// Header
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

              /// AI-Driven Smart Reminder
              BlocBuilder<
                Reminder_Mode_BottonSheet_Cubit,
                Reminder_Mode_BottonSheet_State
              >(
                builder: (context, state) {
                  return ReminderOptionCard(
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
                            .read<Reminder_Mode_BottonSheet_Cubit>()
                            .toggleAiReminder(value),
                    activeColor: AppColors.white,
                    activeTrackColor: AppColors.violetBlue,
                  );
                },
              ),
              SizedBox(height: 16.h),

              /// Steady Sip Reminder
              BlocBuilder<
                Reminder_Mode_BottonSheet_Cubit,
                Reminder_Mode_BottonSheet_State
              >(
                builder: (context, state) {
                  return ReminderOptionCard(
                    title: AppStrings.steadySipReminder,
                    features: const [
                      AppStrings.fixedIntervals,
                      AppStrings.simpleHydrationAlerts,
                    ],
                    isActive: state.steadySipReminder,
                    onToggle:
                        (value) => context
                            .read<Reminder_Mode_BottonSheet_Cubit>()
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
