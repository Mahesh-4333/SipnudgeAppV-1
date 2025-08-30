import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';
import 'package:flutterapp1/cubit/Preferences/preferences_cubit.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';
import 'package:flutterapp1/widgets/preferences_widgets/menu_item_tile.dart';
import 'package:flutterapp1/widgets/preferences_widgets/toggle_tile.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PreferencesCubit(),
      child: BlocBuilder<PreferencesCubit, PreferencesState>(
        builder: (context, state) {
          final cubit = context.read<PreferencesCubit>();

          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // ✅ Header
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
                          SizedBox(width: AppDimensions.dim100.w),
                          Text(
                            AppStrings.preferences,
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

                    SizedBox(height: 30.h),

                    // ✅ Menu Group
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.dim20.w,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white1A,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.dim16.r,
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.25),
                          //     offset: const Offset(4, 4),
                          //     blurRadius: 8.r,
                          //   ),
                          // ],
                        ),
                        child: Column(
                          children: [
                            MenuItemTile(
                              title: AppStrings.waterIntakeGoal,
                              info: '2,500 mL',
                            ),
                            MenuItemTile(
                              title: AppStrings.cupUnits,
                              info: 'mL',
                            ),
                            MenuItemTile(
                              title: AppStrings.weightUnit,
                              info: 'kg',
                            ),
                            MenuItemTile(
                              title: AppStrings.heightUnit,
                              info: 'cm',
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: AppDimensions.dim25.h),

                    // ✅ Toggles
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.dim20.w,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(AppDimensions.dim16.w),
                        decoration: BoxDecoration(
                          color: AppColors.white1A,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.dim16.r,
                          ),
                        ),
                        child: Column(
                          children: [
                            ToggleTile(
                              title: AppStrings.hapticFeedback,
                              value: state.hapticFeedback,
                              onChanged: cubit.toggleHapticFeedback,
                            ),
                            SizedBox(height: AppDimensions.dim12.h),
                            ToggleTile(
                              title: AppStrings.wakeUpTimeAsAlarm,
                              value: state.wakeUpAlarm,
                              onChanged: cubit.toggleWakeUpAlarm,
                            ),
                            SizedBox(height: AppDimensions.dim12.h),
                            ToggleTile(
                              title: AppStrings.ledFeedback,
                              value: state.ledFeedback,
                              onChanged: cubit.toggleLedFeedback,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: AppDimensions.dim20.h),

                    // ✅ Restart Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                        width: double.infinity, // ✅ makes button full width
                        child: ElevatedButton(
                          onPressed: () {
                            // Add cubit reset logic if needed
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.sunset,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radius_16.r,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: AppDimensions.dim10.h,
                            ), // ✅ taller button
                          ),
                          child: Text(
                            AppStrings.restartalltracking,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: AppFontStyles.fontSize_20.sp,
                              fontFamily: AppFontStyles.urbanistFontFamily,
                              fontVariations: [
                                FontVariation(
                                  'wght',
                                  AppFontStyles.semiBoldFontVariation.value,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // ✅ Reusable BottomNav
                    CustomBottomNavBar(
                      activeTab: 'Home',
                      onTabSelected: cubit.updateActiveTab,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
