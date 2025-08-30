import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';
import 'package:flutterapp1/constants/app_strings.dart';
import 'package:flutterapp1/cubit/account&security/account&security_cubit.dart';
import 'package:flutterapp1/cubit/account&security/account&security_state.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/account&security_widgets/toggle_state_widget.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';
// import 'package:flutterapp1/widgets/account&security_widgets/toggle_state_widget.dart';

class AccountAndSecurityPage extends StatelessWidget {
  const AccountAndSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountSecurityCubit(),
      child: const _AccountAndSecurityView(),
    );
  }
}

class _AccountAndSecurityView extends StatelessWidget {
  const _AccountAndSecurityView();

  @override
  Widget build(BuildContext context) {
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
              // Top Header
              Padding(
                padding: EdgeInsets.only(
                  top: AppDimensions.dim40.h,
                  left: AppDimensions.dim20.w,
                  right: AppDimensions.dim20.w,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: AppDimensions.dim40.w,
                      height: AppDimensions.dim40.w,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.black,
                          size: AppFontStyles.fontSize_30,
                        ),
                      ),
                    ),
                    SizedBox(width: AppDimensions.dim50.w),
                    const Text(
                      'Account & Security',
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
              SizedBox(height: 50.h),

              // Toggle Container
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radius_16.r,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AccountSecurityCubit, AccountSecurityState>(
                        builder: (context, state) {
                          return ToggleTile(
                            title: 'Biomatrics ID',
                            value: state.biometricsEnabled,
                            onChanged:
                                (val) => context
                                    .read<AccountSecurityCubit>()
                                    .toggleBiometrics(val),
                          );
                        },
                      ),
                      SizedBox(height: AppDimensions.dim12.h),
                      BlocBuilder<AccountSecurityCubit, AccountSecurityState>(
                        builder: (context, state) {
                          return ToggleTile(
                            title: 'Face ID',
                            value: state.faceIdEnabled,
                            onChanged:
                                (val) => context
                                    .read<AccountSecurityCubit>()
                                    .toggleFaceId(val),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppDimensions.dim20.h),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.dim20.w,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        //color: Color(0xFFEA966F),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius_100.r,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackwithopacity25,
                            offset: Offset(
                              AppDimensions.radius_4.r,
                              AppDimensions.radius_4.r,
                            ),
                            blurRadius: AppDimensions.radius_4.r,
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          //backgroundColor: Colors.transparent,
                          backgroundColor: AppColors.salmonwithopacity22,
                          padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.dim5.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radius_100.r,
                            ),
                          ),
                        ),
                        child: Text(
                          AppStrings.deleteaccount,
                          style: TextStyle(
                            fontSize: AppFontStyles.fontSize_20,
                            fontVariations: [
                              FontVariation(
                                'wght',
                                AppFontStyles.semiBoldFontVariation.value,
                              ),
                            ],
                            color: AppColors.mangoorange,
                            fontFamily: AppFontStyles.urbanistFontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.all(AppDimensions.dim10.w),
                    child: Text(
                      AppStrings.accountremove,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppFontStyles.fontSize_12,
                        fontVariations: [
                          FontVariation(
                            'wght',
                            AppFontStyles.regularFontVariation.value,
                          ),
                        ],
                        color: AppColors.white,
                        fontFamily: AppFontStyles.urbanistFontFamily,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              // Bottom Spacing
              // BlocBuilder<AccountSecurityCubit, AccountSecurityState>(
              //   builder: (context, state) {
              //     return CustomBottomNavBar(
              //       activeTab: 'Home',
              //       onTabSelected: (label) {
              //         context.read<AccountSecurityCubit>().updateTab(label);
              //         NavigationHelper.navigate(context, label);
              //       },
              //     );
              //   },
              // ),
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
      ),
    );
  }
}
