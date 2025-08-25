import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              colors: [Color(0xFFB586BE), Color(0xFF131313)],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reminder Mode',
                    style: TextStyle(
                      fontFamily: 'Urbanist-SemiBold',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 22.sp,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // AI-Driven Smart Reminder
              BlocBuilder<ReminderCubit, ReminderState>(
                builder: (context, state) {
                  return _ReminderOptionCard(
                    title: 'AI-Driven Smart Reminder',
                    subtitle: '"Predictive Hydration"',
                    features: const [
                      'Adapts to your schedule, weather, and activity',
                      'Syncs with Google Calendar',
                      'Smart snooze and personalized tips',
                    ],
                    isActive: state.aiReminder,
                    onToggle:
                        (value) => context
                            .read<ReminderCubit>()
                            .toggleAiReminder(value),
                    activeColor: const Color(0xFFFFFFFF),
                    activeTrackColor: const Color(0xFF6C00C3),
                  );
                },
              ),
              SizedBox(height: 16.h),

              // Steady Sip Reminder
              BlocBuilder<ReminderCubit, ReminderState>(
                builder: (context, state) {
                  return _ReminderOptionCard(
                    title: 'Steady Sip Reminder',
                    features: const [
                      'Fixed intervals (e.g., every 2 hours)',
                      'Simple hydration alerts',
                    ],
                    isActive: state.steadySipReminder,
                    onToggle:
                        (value) => context
                            .read<ReminderCubit>()
                            .toggleSteadySipReminder(value),
                    activeColor: const Color(0xFFFFFFFF),
                    activeTrackColor: const Color(0xFF6C00C3),
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color:
            isActive
                ? const Color(0xFF584861) // active background
                : const Color(0x90735E7F), // inactive background
        border: Border.all(
          color: const Color(0xFFB889D2),
          width: isActive ? 2.w : 1.w, // active/inactive border width
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
                      fontFamily: 'Urbanist-SemiBold',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFFFFFF),
                      letterSpacing: 0.2,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontFamily: 'Urbanist-Medium',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFFFFFF),
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

          Divider(color: const Color(0x46FFFFFF), thickness: 1.5),
          SizedBox(height: 12.h),

          // Features
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                features
                    .map(
                      (f) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white70,
                              size: 16.sp,
                            ),
                            SizedBox(width: 9.w),
                            Expanded(
                              child: Text(
                                f,
                                style: TextStyle(
                                  fontFamily: 'Urbanist-Medium',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFFFFFFF),
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
