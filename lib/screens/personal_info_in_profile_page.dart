// personal_info_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              colors: [Color(0xFFB586BE), Color(0xFF131313)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(context, size),
                SizedBox(height: size.height * 0.05),
                _buildInfoCard(),
                const Spacer(),
                //_buildBottomNav(size),
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

  Widget _buildHeader(BuildContext context, Size size) {
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.05,
        left: size.width * 0.06,
        right: size.width * 0.05,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 30.sp),
          ),
          SizedBox(width: size.width * 0.19),
          const Text(
            'Personal Info',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'urbanist-Bold',
              fontWeight: FontWeight.w700,
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
              color: const Color(0x1AFFFFFF),
              borderRadius: BorderRadius.circular(16),
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
