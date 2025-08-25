import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/cubit/reminder time&mode/reminder_time_interval_cubit.dart';
import 'package:flutterapp1/cubit/reminder time&mode/reminder_time_interval_state.dart';
import 'package:flutterapp1/widgets/reminder_timeinterval_bottom_sheet.dart';

import '../cubit/reminder time&mode/reminder_cubit.dart';

class IntervalBottomSheet extends StatelessWidget {
  const IntervalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimeIntervalCubit(),
      child: GestureDetector(
        onTap: () {
          // Prevent closing on tapping anywhere inside the sheet
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.black.withOpacity(0.5), // Background overlay
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  bottom: 30.h,
                  top: 10.h,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFB586BE), Color(0xFF131313)],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(context), // Pass context here
                    _buildContent(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.only(left: 20.w, top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Reminder Time',
            style: TextStyle(
              fontFamily: 'Urbanist-SemiBold',
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFFFFF),
              fontSize: 24.sp,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context); // Now context is available here
            },
            icon: Icon(Icons.close, color: Color(0xFFFFFFFF), size: 22.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left side: label
          Text(
            'Select Sip Interval',
            style: TextStyle(
              fontFamily: 'Urbanist-SemiBold',
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFFFFF),
              fontSize: 20.sp, // responsive font size
            ),
          ),

          /// Right side: button + icon
          BlocBuilder<TimeIntervalCubit, TimeIntervalState>(
            builder: (context, state) {
              String interval = '';
              if (state is TimeIntervalUpdated) {
                interval = state.interval;
              } else if (state is TimeIntervalInitial) {
                interval = state.interval;
              }

              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<TimeIntervalCubit>().updateInterval();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 6.h,
                        horizontal: 6.w,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0x22EAEAEA),
                        // gradient: LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   colors: [Color(0xFFB586BE), Color(0xFF131313)],
                        // ),
                        border: Border.all(color: Colors.white, width: 1.w),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Text(
                        interval,
                        style: TextStyle(
                          fontFamily: 'Urbanist-SemiBold',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.sp, // responsive font size
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w), // responsive gap
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18.sp, // responsive icon size
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder:
                            (_) => BlocProvider.value(
                              value:
                                  context
                                      .read<
                                        ReminderIntervalCubit
                                      >(), // reuse existing cubit
                              child: ReminderBottomSheet(
                                aiReminder:
                                    true, // pass true/false depending on your logic
                                onSave: (selectedTimes) {
                                  // Handle the selected reminder times here
                                  debugPrint("Selected times: $selectedTimes");
                                },
                              ),
                            ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
