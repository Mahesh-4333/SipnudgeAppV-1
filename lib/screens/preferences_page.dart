import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  colors: [Color(0xFFB586BE), Color(0xFF131313)],
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
                        top: 40.h,
                        left: 20.w,
                        right: 20.w,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 30.sp,
                            ),
                          ),
                          SizedBox(width: 100.w),
                          const Text(
                            'Preferences',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'urbanist-Bold',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // ✅ Menu Group
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0x1AFFFFFF),
                          borderRadius: BorderRadius.circular(16.r),
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
                              title: 'Water Intake Goal',
                              info: '2,500 mL',
                            ),
                            MenuItemTile(title: 'Cup Units', info: 'mL'),
                            MenuItemTile(title: 'Weight Unit', info: 'kg'),
                            MenuItemTile(title: 'Height Unit', info: 'cm'),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // ✅ Toggles
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0x1AFFFFFF),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            ToggleTile(
                              title: 'Haptic Feedback',
                              value: state.hapticFeedback,
                              onChanged: cubit.toggleHapticFeedback,
                            ),
                            SizedBox(height: 12.h),
                            ToggleTile(
                              title: 'Wake-up Time as Alarm',
                              value: state.wakeUpAlarm,
                              onChanged: cubit.toggleWakeUpAlarm,
                            ),
                            SizedBox(height: 12.h),
                            ToggleTile(
                              title: 'LED Feedback',
                              value: state.ledFeedback,
                              onChanged: cubit.toggleLedFeedback,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

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
                            backgroundColor: const Color(0xFFFBD9A6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                            ), // ✅ taller button
                          ),
                          child: Text(
                            'Restart All Tracking',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontFamily: 'Urbanist-SemiBold',
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
