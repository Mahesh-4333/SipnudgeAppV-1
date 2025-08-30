import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';
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
    return BlocProvider(
      create: (_) => DrinkReminderCubit(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
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
                        top: AppDimensions.dim40.h,
                        left: AppDimensions.dim20.w,
                        right: AppDimensions.dim20.w,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppColors.black,
                              size: AppFontStyles.fontSize_30.sp,
                            ),
                          ),
                          SizedBox(width: AppDimensions.dim50.w),
                          Text(
                            'Drink Reminder',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: AppFontStyles.fontSize_24.sp,
                              fontFamily: AppFontStyles.urbanistFontFamily,
                              fontVariations: [
                                FontVariation(
                                  'wght',
                                  AppFontStyles.boldFontVariation.value,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppDimensions.dim24.h),

                    /// Main Content
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.dim16.w,
                      ),
                      child:
                          BlocBuilder<DrinkReminderCubit, DrinkReminderState>(
                            builder: (context, state) {
                              final cubit = context.read<DrinkReminderCubit>();
                              return Column(
                                children: [
                                  ReminderCard(
                                    children: [
                                      ReminderToggleRow(
                                        title: AppStrings.reminder,
                                        value: state.reminderEnabled,
                                        onChanged: cubit.toggleReminder,
                                      ),
                                      ReminderListItem(
                                        title: AppStrings.reminderMode,
                                        trailing: state.reminderMode,
                                        onTap: () => _showReminderMode(context),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppDimensions.dim16.h),
                                  ReminderCard(
                                    children: [
                                      ReminderCycleItem(
                                        title: AppStrings.smartSkip,
                                        value:
                                            cubit.smartSkipOptions[state
                                                .smartSkipIndex],
                                        onTap: cubit.cycleSmartSkip,
                                      ),
                                      ReminderCycleItem(
                                        title: AppStrings.alarmRepeat,
                                        value:
                                            cubit.alarmRepeatOptions[state
                                                .alarmRepeatIndex],
                                        onTap: cubit.cycleAlarmRepeat,
                                      ),
                                      ReminderToggleRow(
                                        title: AppStrings.stopWhen100,
                                        value: state.stopWhenFull,
                                        onChanged: cubit.toggleStopWhenFull,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppDimensions.dim16.h),
                                  ReminderCard(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: AppDimensions.dim8.h,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            AppStrings.remindersetting,
                                            style: TextStyle(
                                              fontSize:
                                                  AppFontStyles.fontSize_20.sp,
                                              // fontWeight: FontWeight.w700,
                                              color: AppColors.white,
                                              fontFamily:
                                                  AppFontStyles
                                                      .urbanistFontFamily,
                                              fontVariations: [
                                                FontVariation(
                                                  'wght',
                                                  AppFontStyles
                                                      .boldFontVariation
                                                      .value,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: AppColors.white54,
                                        thickness: AppFontStyles.fontSize_1.sp,
                                      ),
                                      ReminderListItem(
                                        title: AppStrings.waterintaketimeline,
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
                  left: AppDimensions.dim6.w,
                  right: AppDimensions.dim6.w,
                  bottom: AppDimensions.dim6.h,
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
