import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/cubit/linkaccounts/link_accounts_cubit.dart';
import 'package:flutterapp1/cubit/linkaccounts/link_accounts_state.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';
import 'package:flutterapp1/widgets/link_accounts_widgets/social_media_button_widget.dart';

class LinkAccountsPage extends StatelessWidget {
  const LinkAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LinkAccountsCubit(),
      child: Scaffold(
        body: Container(
          width: 1.sw, // full screen width
          height: 1.sh, // full screen height
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB586BE), Color(0xFF131313)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                /// Page Content
                Column(
                  children: [
                    /// 🔹 Top user info
                    Padding(
                      padding: EdgeInsets.only(
                        top: 40.h,
                        left: 20.w,
                        right: 20.w,
                      ),
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
                          SizedBox(width: 70.w),
                          Text(
                            'Link Accounts',
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

                    /// 🔹 Social Buttons
                    BlocBuilder<LinkAccountsCubit, LinkAccountsState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: buildSocialButton(
                                iconPath: 'assets/google_icon.png',
                                label: 'Google',
                                label1:
                                    state.connectedAccounts['Google']!
                                        ? 'Connected'
                                        : 'Connect',
                                onPressed:
                                    () => context
                                        .read<LinkAccountsCubit>()
                                        .toggleConnection("Google"),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: buildSocialButton(
                                iconPath: 'assets/apple_icon.png',
                                label: 'Apple',
                                label1:
                                    state.connectedAccounts['Apple']!
                                        ? 'Connected'
                                        : 'Connect',
                                iconColor: const Color(0xFFC89DE9),
                                onPressed:
                                    () => context
                                        .read<LinkAccountsCubit>()
                                        .toggleConnection("Apple"),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const Spacer(),
                  ],
                ),

                /// 🔹 Custom Bottom Nav
                Positioned(
                  left: 6.w,
                  right: 6.w,
                  bottom: 6.h,
                  child: BlocBuilder<LinkAccountsCubit, LinkAccountsState>(
                    builder: (context, state) {
                      return CustomBottomNavBar(
                        activeTab: state.activeTab,
                        onTabSelected: (label) {
                          context.read<LinkAccountsCubit>().updateTab(label);
                          NavigationHelper.navigate(context, label);
                        },
                      );
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
