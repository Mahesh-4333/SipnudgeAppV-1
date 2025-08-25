import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/cubit/drinkreminder/drink_reminder_cubit.dart';
import 'package:flutterapp1/cubit/drinkreminder/drink_reminder_state.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/drinkreminder_widget/reminder_card.dart';
import 'package:flutterapp1/widgets/drinkreminder_widget/reminder_cycle_item.dart';
import 'package:flutterapp1/widgets/drinkreminder_widget/reminder_list_item.dart';
import 'package:flutterapp1/widgets/drinkreminder_widget/reminder_toggle_row.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';
import 'package:flutterapp1/widgets/custom_bttom_sheet_rm.dart';

class DrinkReminder extends StatelessWidget {
  const DrinkReminder({super.key});

  void _showReminderMode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ReminderBottomSheet(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => DrinkReminderCubit(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB586BE), Color(0xFF131313)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.06,
                        left: screenWidth * 0.06,
                        right: screenWidth * 0.06,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF212121),
                              size: 30.sp,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.15),
                          Text(
                            'Drink Reminder',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontFamily: 'urbanist-Bold',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    /// Main Content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child:
                          BlocBuilder<DrinkReminderCubit, DrinkReminderState>(
                            builder: (context, state) {
                              final cubit = context.read<DrinkReminderCubit>();
                              return Column(
                                children: [
                                  ReminderCard(
                                    children: [
                                      ReminderToggleRow(
                                        title: 'Reminder',
                                        value: state.reminderEnabled,
                                        onChanged: cubit.toggleReminder,
                                      ),
                                      ReminderListItem(
                                        title: 'Reminder Mode',
                                        trailing: state.reminderMode,
                                        onTap: () => _showReminderMode(context),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                  ReminderCard(
                                    children: [
                                      ReminderCycleItem(
                                        title: 'Smart Skip',
                                        value:
                                            cubit.smartSkipOptions[state
                                                .smartSkipIndex],
                                        onTap: cubit.cycleSmartSkip,
                                      ),
                                      ReminderCycleItem(
                                        title: 'Alarm Repeat',
                                        value:
                                            cubit.alarmRepeatOptions[state
                                                .alarmRepeatIndex],
                                        onTap: cubit.cycleAlarmRepeat,
                                      ),
                                      ReminderToggleRow(
                                        title: 'Stop When 100%',
                                        value: state.stopWhenFull,
                                        onChanged: cubit.toggleStopWhenFull,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                  ReminderCard(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Reminder Settings',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontFamily: 'Urbanist-Bold',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.white54,
                                        thickness: 1.sp,
                                      ),
                                      ReminderListItem(
                                        title: 'Water Intake Timeline',
                                        trailing: '',
                                        onTap:
                                            () => Navigator.pushNamed(
                                              context,
                                              '/waterintaketimeline',
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                    ),
                    const Spacer(),
                  ],
                ),

                /// 🔹 Custom Bottom Nav Bar (your provided replacement)
                Positioned(
                  left: 6.w,
                  right: 6.w,
                  bottom: 6.h,
                  child: CustomBottomNavBar(
                    activeTab: 'Home',
                    onTabSelected: (label) {
                      NavigationHelper.navigate(context, label);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
