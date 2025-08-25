import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/cubit/customer_support/customer_support_cubit.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/customer_support_widget/customer_support_buttons.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerSupportCubit(),
      child: Scaffold(
        body: Container(
          width: 1.sw,
          height: 1.sh,
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
                /// 🔹 Top Bar
                Padding(
                  padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
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
                      SizedBox(width: 50.w),
                      Text(
                        'Customer Support',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontFamily: 'urbanist-Bold',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50.h),

                /// 🔹 Support Options
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      SupportButton(
                        iconPath: 'assets/customersupporticon.png',
                        label: 'Customer Support',
                        onPressed: () {},
                      ),
                      SizedBox(height: 20.h),
                      SupportButton(
                        iconPath: 'assets/websiteicon.png',
                        label: 'Website',
                        onPressed: () {},
                      ),
                      SizedBox(height: 20.h),
                      SupportButton(
                        iconPath: 'assets/whatsappicon.png',
                        label: 'WhatsApp',
                        onPressed: () {},
                      ),
                      SizedBox(height: 20.h),
                      SupportButton(
                        iconPath: 'assets/instaicon.png',
                        label: 'Instagram',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /// 🔹 Bottom Navigation
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
}
