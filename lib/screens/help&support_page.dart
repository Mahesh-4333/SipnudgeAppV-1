import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/cubit/help&support/help&support_cubil.dart';
import 'package:flutterapp1/cubit/help&support/help&support_state.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/help&support_widgets/help&support_menu_items.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HelpAndSupportCubit(),
      child: const _HelpAndSupportView(),
    );
  }
}

class _HelpAndSupportView extends StatelessWidget {
  const _HelpAndSupportView();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final screenWidth = size.width;
    // final screenHeight = size.height;

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
              // 🔹 Top Header
              Padding(
                padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40.w,
                      height: 40.w,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 80.w),
                    const Text(
                      'Help & Support',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 24,
                        fontFamily: 'urbanist-Bold',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // 🔹 Menu Items
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: const [
                      HelpMenuItem(title: "F&Q", route: "/faq"),
                      HelpMenuItem(
                        title: "Contact Support",
                        route: "/contact_support",
                      ),
                      HelpMenuItem(
                        title: "Privacy Policy",
                        route: "/privacypolicy",
                      ),
                      HelpMenuItem(
                        title: "Terms of Service",
                        route: "/termsofservices",
                      ),
                      HelpMenuItem(title: "About Us", route: "/aboutus"),
                    ],
                  ),
                ),
              ),

              //SizedBox(height: ),
              const Spacer(),

              // 🔹 Bottom Navigation
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
              // BlocBuilder<HelpAndSupportCubit, HelpAndSupportState>(
              //   builder: (context, state) {
              //     return CustomBottomNavBar(
              //       activeTab: 'Home',
              //       onTabSelected: (label) {
              //         NavigationHelper.navigate(context, label);
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
