import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';
import 'package:flutterapp1/cubit/profile_screen_in_setting/profile_cubit.dart';
import 'package:flutterapp1/cubit/profile_screen_in_setting/profile_state.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';
import 'package:flutterapp1/widgets/profile_screen_inSetting/profile_menu_item.dart';

class ProfileScreenPage extends StatelessWidget {
  const ProfileScreenPage({super.key});

  void _handleNavigation(BuildContext context, String title) {
    switch (title) {
      case AppStrings.personalinfo:
        Navigator.pushNamed(context, '/personalinfoinprofile');
        break;
      case AppStrings.drinkreminder:
        Navigator.pushNamed(context, '/drinkreminder');
        break;
      case AppStrings.sipnudgebottle:
        Navigator.pushNamed(context, '/sipnudge_bottle');
        break;
      case AppStrings.preferences:
        Navigator.pushNamed(context, '/preferences');
        break;
      case AppStrings.dataAnalytics:
        Navigator.pushNamed(context, '/data&analytics');
        break;
      case AppStrings.linkaccounts:
        Navigator.pushNamed(context, '/linked_accounts');
        break;
      case AppStrings.helpandsupport:
        Navigator.pushNamed(context, '/support');
        break;
      case AppStrings.accountandsecurity:
        Navigator.pushNamed(context, '/account_security');
        break;
      case AppStrings.logout:
        _showLogoutConfirmation(context);
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$title screen coming soon!')));
    }
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color(0xFF2A2A2A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radius_16.r),
            ),
            title: const Text(
              AppStrings.logout,
              style: TextStyle(color: AppColors.white),
            ),
            content: const Text(
              AppStrings.areYouSureYouWantToLogout,
              style: TextStyle(color: AppColors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  AppStrings.cancel,
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(AppStrings.loggedOutSuccessfully),
                    ),
                  );
                },
                child: const Text(
                  AppStrings.logout,
                  style: TextStyle(color: AppColors.redAccent),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
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
              child: Column(
                children: [
                  // user info
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppDimensions.dim50.h,
                      left: AppDimensions.dim25.w,
                      right: AppDimensions.dim25.w,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(
                                  0x001f436d,
                                ).withOpacity(0.40), // Shadow color
                                blurRadius:
                                    AppDimensions
                                        .radius_6
                                        .r, // Softness of the shadow
                                offset: Offset(
                                  0,
                                  AppDimensions.radius_4.r,
                                ), // Vertical drop
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: AppDimensions.dim30.r,
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              'assets/person.png',
                              width: AppDimensions.dim70.w,
                              height: AppDimensions.dim70.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        SizedBox(width: AppDimensions.dim16.w),
                        Text(
                          AppStrings.newtonsingh,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: AppFontStyles.fontSize_18.sp,
                            fontFamily: AppFontStyles.museoModernoFontFamily,
                            fontVariations: [
                              FontVariation(
                                'wght',
                                AppFontStyles.semiBoldFontVariation.value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimensions.dim30.h),

                  // first menu group
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.dim24.w,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius_16.r,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              0.10,
                            ), // shadow color only
                            blurRadius: 2.r,
                            spreadRadius: 3.r,
                            offset: Offset(3.5.r, 3.5.r), // even shadow
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              AppColors
                                  .white1A, // actual white container without shadow
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radius_16.r,
                          ),
                        ),
                        child: Column(
                          children:
                              state.menuItems
                                  .map(
                                    (item) => ProfileMenuItemWidget(
                                      iconPath: item.iconPath,
                                      title: item.title,
                                      isRed: item.isRed,
                                      iconPathArrow: ("assets/arrow.png"),
                                      onTap:
                                          () => _handleNavigation(
                                            context,
                                            item.title,
                                          ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                  ),

                  //),
                  SizedBox(height: AppDimensions.dim34.h),

                  // second menu group
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.dim24.w,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius_16.r,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              0.10,
                            ), // shadow color only
                            blurRadius: 2.r,
                            spreadRadius: 3.r,
                            offset: Offset(3.5.r, 3.5.r), // even shadow
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              AppColors
                                  .white1A, // actual white container without shadow
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radius_16.r,
                          ),
                        ),
                        child: Column(
                          children:
                              state.secondaryMenuItems
                                  .map(
                                    (item) => ProfileMenuItemWidget(
                                      iconPath: item.iconPath,
                                      title: item.title,
                                      isRed: item.isRed,
                                      iconPathArrow: ("assets/arrow.png"),
                                      onTap:
                                          () => _handleNavigation(
                                            context,
                                            item.title,
                                          ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // bottom nav bar
                  CustomBottomNavBar(
                    activeTab: state.activeTab,
                    onTabSelected: (label) {
                      context.read<ProfileCubit>().changeTab(label);
                      NavigationHelper.navigate(context, label);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
