// personal_info_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';
import 'package:flutterapp1/cubit/personal_info_in_profile/personal_info_cubit.dart';
import 'package:flutterapp1/cubit/personal_info_in_profile/personal_info_state.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';

import 'package:flutterapp1/widgets/personal_info_in_profile/personal_info_manu_item.dart';

class PersonalInfoScreenInProfile extends StatefulWidget {
  const PersonalInfoScreenInProfile({super.key});

  @override
  State<PersonalInfoScreenInProfile> createState() =>
      _PersonalInfoScreenInProfileState();
}

class _PersonalInfoScreenInProfileState
    extends State<PersonalInfoScreenInProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => PersonalInfoCubit(),
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
            child: Column(
              children: [
                _buildHeader(context, size),
                SizedBox(height: AppDimensions.dim50.h),
                _buildInfoCard(),
                const Spacer(),
                //_buildBottomNav(size),
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

  Widget _buildHeader(BuildContext context, Size size) {
    return Padding(
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
              color: Colors.black,
              size: AppFontStyles.fontSize_30.sp,
            ),
          ),
          SizedBox(width: AppDimensions.dim50.w),
          Text(
            AppStrings.personalInformation,
            style: TextStyle(
              color: AppColors.white,
              fontSize: AppFontStyles.fontSize_24.sp,
              fontFamily: AppFontStyles.urbanistFontFamily,
              fontVariations: [
                FontVariation('wght', AppFontStyles.boldFontVariation.value),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white1A,
              borderRadius: BorderRadius.circular(AppDimensions.radius_16.r),
              // boxShadow: [
              //   BoxShadow(
              //     offset: const Offset(0, 6),
              //     blurRadius: 12,
              //     spreadRadius: 2,
              //     color: Colors.black.withOpacity(0.25),
              //   ),
              // ],
            ),
            child: Column(
              children:
                  state.personalInfo.entries
                      .map(
                        (e) => MenuItem(
                          title: e.key,
                          info: e.value,
                          onTap: () => _handleNavigation(context, e.key),
                        ),
                      )
                      .toList(),
            ),
          ),
        );
      },
    );
  }

  // Widget _buildBottomNav(Size size) {
  void _handleNavigation(BuildContext context, String title) {
    switch (title) {
      case 'Gender':
      case 'Height':
      case 'Weight':
      case 'Age':
        Navigator.pushNamed(context, '/personalinfo');
        break;
      case 'Wake-up Time':
      case 'Bedtime':
      case 'Activity Level':
        Navigator.pushNamed(context, '/lifestyleinfo');
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$title screen coming soon!')));
    }
  }
}
