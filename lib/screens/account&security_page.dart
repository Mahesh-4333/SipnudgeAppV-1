import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            colors: [Color(0xFFB586BE), Color(0xFF131313)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Header
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
                    SizedBox(width: 50.w),
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
                    borderRadius: BorderRadius.circular(16.r),
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
                      SizedBox(height: 12.h),
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

              SizedBox(height: 20.h),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      decoration: BoxDecoration(
                        //color: Color(0xFFEA966F),
                        borderRadius: BorderRadius.circular(100.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x25000000).withOpacity(0.25),
                            offset: Offset(4.w, 4.h),
                            blurRadius: 4.r,
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          //backgroundColor: Colors.transparent,
                          backgroundColor: const Color(0x22EA966F),
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                            color: const Color(0xFFFC813A),
                            fontSize: 20.sp,
                            fontFamily: 'Urbanist-SemiBold',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Text(
                      'Permanently remove your account and data. Proceed with caution.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFFFFFFF),
                        fontFamily: 'urbanist-medium',
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
    );
  }
}
