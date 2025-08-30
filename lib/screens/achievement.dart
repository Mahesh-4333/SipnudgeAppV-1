import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';
import 'package:flutterapp1/cubit/level/level_cubit.dart';
import 'package:flutterapp1/cubit/level/level_state.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';
import 'package:flutterapp1/widgets/level_widgets/concentric_circles_animation.dart';
import 'package:flutterapp1/widgets/level_widgets/level_grid.dart';

import '../levelreached.dart'; // for showLevelUpDialog

class BadgeWithConcentricBackground extends StatelessWidget {
  const BadgeWithConcentricBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, state) {
        var currentLevel = state.currentLevel;

        return Scaffold(
          body: Stack(
            children: [
              Container(
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
                  child: Column(
                    children: [
                      // Top section
                      Expanded(
                        flex: 5,
                        child: Stack(
                          children: [
                            Positioned(
                              top: AppDimensions.dim20.h,
                              left: AppDimensions.dim20.w,
                              // top: 20.h,
                              // left: 20.w,
                              child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30.sp,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: ConcentricCirclesAnimation(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: AppDimensions.dim20.w,
                                      ),
                                      child: Image.asset(
                                        'assets/achievmentimage.png',
                                        width: AppDimensions.dim330.w,
                                        height: AppDimensions.dim320.h,
                                        // width: 330.w,
                                        // height: 320.h,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: AppDimensions.dim16.w,
                                      ),
                                      child: ShaderMask(
                                        shaderCallback:
                                            (bounds) => const LinearGradient(
                                              colors: [
                                                AppColors.aztecpurple,
                                                AppColors.darkviolet,
                                                AppColors.richlilac,
                                                AppColors.purplemimosa,
                                                // Color(0xFF8C41FD),
                                                // Color(0xFF7800BD),
                                                // Color(0xFFAE58E0),
                                                // Color(0xFFA66CFD),
                                              ],
                                            ).createShader(
                                              Rect.fromLTWH(
                                                0,
                                                0,
                                                bounds.width,
                                                bounds.height,
                                              ),
                                            ),
                                        blendMode: BlendMode.srcIn,
                                        child: Transform.translate(
                                          offset: Offset(0, -5.h),
                                          child: Text(
                                            '$currentLevel',
                                            style: TextStyle(
                                              fontSize:
                                                  AppFontStyles.fontSize_74.sp,
                                              fontVariations: [
                                                FontVariation(
                                                  'wght',
                                                  AppFontStyles
                                                      .extraBoldFontVariation
                                                      .value,
                                                ),
                                              ],
                                              //fontWeight: FontWeight.w900,
                                              fontFamily:
                                                  AppFontStyles.poppinsFamily,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Congrats text
                            Positioned(
                              top: AppDimensions.dim338.h,
                              left: AppDimensions.dim20.w,
                              right: AppDimensions.dim20.w,
                              child: Column(
                                children: [
                                  Text(
                                    '${AppStrings.levelreach} $currentLevel',
                                    //"You've Reached Level $currentLevel!",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontFamily:
                                          AppFontStyles.urbanistFontFamily,
                                      fontSize: AppFontStyles.fontSize_20.sp,
                                      fontVariations: [
                                        FontVariation(
                                          'wght',
                                          AppFontStyles.boldFontVariation.value,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: AppDimensions.dim10.h),
                                  Text(
                                    AppStrings.congratulations,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily:
                                          AppFontStyles.urbanistFontFamily,
                                      fontVariations: [
                                        FontVariation(
                                          'wght',
                                          AppFontStyles
                                              .semiBoldFontVariation
                                              .value,
                                        ),
                                      ],
                                      color: AppColors.whitewithopactiy50,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Grid Section
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            // Grid content
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  AppDimensions.radius_40.r,
                                ),
                                topRight: Radius.circular(
                                  AppDimensions.radius_40.r,
                                ),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.whitewithopactiy12,
                                ),
                                child: GridView.builder(
                                  padding: EdgeInsets.only(
                                    left: AppDimensions.dim10.w,
                                    right: AppDimensions.dim10.w,
                                    top: AppDimensions.dim10.h,
                                    bottom: AppDimensions.dim90.h,
                                    // leave space for nav bar
                                  ),
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 0.94.r,
                                      ),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    final level = index + 1;
                                    return LevelGridItem(
                                      level: level,
                                      currentLevel: currentLevel,
                                      onTap: () {
                                        if (level > currentLevel) {
                                          context
                                              .read<LevelCubit>()
                                              .updateLevel(level);
                                          showLevelUpDialog(
                                            context,
                                            level,
                                            '15.4L',
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),

                            // Floating Bottom Navigation Bar (replaced inline code with CustomBottomNavBar)
                            Positioned(
                              left: AppDimensions.dim6.w,
                              right: AppDimensions.dim6.w,
                              bottom: AppDimensions.dim6.w,
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
                    ],
                  ),
                ),
              ),

              // 🔽 Bottom Nav Bar overlay
            ],
          ),
        );
      },
    );
  }
}
