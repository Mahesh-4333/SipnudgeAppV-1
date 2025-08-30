import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';
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
          width: AppDimensions.dim1.sw,
          height: AppDimensions.dim1.sh,
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
                /// 🔹 Top Bar
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
                      SizedBox(width: AppDimensions.dim50.w),
                      Text(
                        AppStrings.customersupport,
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

                SizedBox(height: AppDimensions.dim50.h),

                /// 🔹 Support Options
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.dim30.w,
                  ),
                  child: Column(
                    children: [
                      SupportButton(
                        iconPath: 'assets/customersupporticon.png',
                        label: 'Customer Support',
                        onPressed: () {},
                      ),
                      SizedBox(height: AppDimensions.dim20.h),
                      SupportButton(
                        iconPath: 'assets/websiteicon.png',
                        label: 'Website',
                        onPressed: () {},
                      ),
                      SizedBox(height: AppDimensions.dim20.h),
                      SupportButton(
                        iconPath: 'assets/whatsappicon.png',
                        label: 'WhatsApp',
                        onPressed: () {},
                      ),
                      SizedBox(height: AppDimensions.dim20.h),
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
}
