import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/cubit/data&aanlytics/data&analytics_cubit.dart';
import 'package:flutterapp1/cubit/data&aanlytics/data&analytics_state.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/data&analytics_widgets/download_card.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';

class DataAndAnalyticsPage extends StatefulWidget {
  const DataAndAnalyticsPage({super.key});

  @override
  State<DataAndAnalyticsPage> createState() => _DataAndAnalyticsPageState();
}

class _DataAndAnalyticsPageState extends State<DataAndAnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DataAndanalyticsCubit(),
      child: BlocBuilder<DataAndanalyticsCubit, DataAndAnalyticsInitial>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB586BE), Color(0xFF1E1E1E)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              color: AppColors.raisinblack,
                              size: AppFontStyles.fontSize_30.sp,
                            ),
                          ),
                          SizedBox(width: AppDimensions.dim55.w),
                          Text(
                            'Data & Analytics',
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

                    SizedBox(height: 20.h),

                    // Download Card
                    DownloadCard(
                      onTap: () {
                        // Navigate or handle logic
                      },
                    ),

                    const Spacer(),

                    // Bottom nav bar (just mock UI)
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
          );
        },
      ),
    );
  }
}
