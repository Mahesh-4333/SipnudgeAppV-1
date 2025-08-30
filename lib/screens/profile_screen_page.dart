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
        Navigator.pushNamed(context, '/analytics');
        break;
      case AppStrings.accountandsecurity:
        Navigator.pushNamed(context, '/account_security');
        break;
      case AppStrings.linkaccounts:
        Navigator.pushNamed(context, '/linked_accounts');
        break;
      case AppStrings.helpandsupport:
        Navigator.pushNamed(context, '/support');
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
                colors: [Color(0xFFB586BE), Color(0xFF131313)],
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
                      top: AppDimensions.dim40.h,
                      left: AppDimensions.dim20.w,
                      right: AppDimensions.dim20.w,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: AppDimensions.dim20.r,
                          backgroundColor: AppColors.white,
                          child: Image.asset('assets/person.png'),
                        ),
                        SizedBox(width: AppDimensions.dim12.w),
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
                  SizedBox(height: AppDimensions.dim50.h),

                  // first menu group
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppDimensions.dim24.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white1A,
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

                  SizedBox(height: AppDimensions.dim34.h),

                  // second menu group
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppDimensions.dim24.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white1A,
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
