import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/cubit/profile_screen_in_setting/profile_cubit.dart';
import 'package:flutterapp1/cubit/profile_screen_in_setting/profile_state.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';
import 'package:flutterapp1/widgets/profile_screen_inSetting/profile_menu_item.dart';

class ProfileScreenPage extends StatelessWidget {
  const ProfileScreenPage({super.key});

  void _handleNavigation(BuildContext context, String title) {
    switch (title) {
      case 'Personal Info':
        Navigator.pushNamed(context, '/personalinfoinprofile');
        break;
      case 'Drink Reminder':
        Navigator.pushNamed(context, '/drinkreminder');
        break;
      case 'Sipnudge Bottle':
        Navigator.pushNamed(context, '/sipnudge_bottle');
        break;
      case 'Preferences':
        Navigator.pushNamed(context, '/preferences');
        break;
      case 'Data & Analytics':
        Navigator.pushNamed(context, '/analytics');
        break;
      case 'Account & Security':
        Navigator.pushNamed(context, '/account_security');
        break;
      case 'Linked Accounts':
        Navigator.pushNamed(context, '/linked_accounts');
        break;
      case 'Help & Support':
        Navigator.pushNamed(context, '/support');
        break;
      case 'Logout':
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
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text("Logout", style: TextStyle(color: Colors.white)),
            content: const Text(
              "Are you sure you want to logout?",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logged out successfully")),
                  );
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.redAccent),
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
        final size = MediaQuery.of(context).size;
        final screenWidth = size.width;
        final screenHeight = size.height;

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
                      top: screenHeight * 0.05,
                      left: screenWidth * 0.06,
                      right: screenWidth * 0.05,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/person.png'),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Newton Singh',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'museoModerno-Bold',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // first menu group
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x1AFFFFFF),
                      borderRadius: BorderRadius.circular(16.r),
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

                  SizedBox(height: screenHeight * 0.042),

                  // second menu group
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x1AFFFFFF),
                      borderRadius: BorderRadius.circular(16.r),
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
