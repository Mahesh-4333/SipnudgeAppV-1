import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/helpers/navigation_helper.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String activeTab; // current active tab
  final Function(String) onTabSelected; // callback when tab tapped

  const CustomBottomNavBar({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    final assetPath = 'assets/${label.toLowerCase()}.png';
    double scale = 1.0;

    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTapDown: (_) => setState(() => scale = 0.9),
          onTapUp: (_) => setState(() => scale = 1.0),
          onTapCancel: () => setState(() => scale = 1.0),
          onTap: () {
            NavigationHelper.navigate(
              context,
              label,
            ); // ✅ centralized navigation
            widget.onTabSelected(label); // ✅ notify parent
          },
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient:
                        isActive
                            ? const LinearGradient(
                              colors: [Color(0xFFFAFAFA), Color(0xFF3E3E3E)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                            : null,
                    color: isActive ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(48.r),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(4, 4),
                        color:
                            isActive
                                ? const Color(0x40000000)
                                : Colors.transparent,
                        blurRadius: 4.r,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Container(
                      width: 75.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        gradient:
                            isActive
                                ? const LinearGradient(
                                  colors: [
                                    Color(0xFFB182BA),
                                    Color(0xFF2D1B31),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                                : null,
                        color: isActive ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(46.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            assetPath,
                            width: 22.w,
                            height: 22.w,
                            color: Colors.white,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                icon,
                                size: 20.w,
                                color: Colors.white,
                              );
                            },
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            label,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.bar_chart, 'label': 'Analysis'},
      {'icon': Icons.flag, 'label': 'Goals'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    return Container(
      height: 75.h,
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF3F3F3F), Color(0xFFFFFFFF)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(1.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2B2536),
            borderRadius: BorderRadius.circular(90.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                tabs.map((tab) {
                  final label = tab['label'] as String;
                  final icon = tab['icon'] as IconData;
                  return _buildNavItem(icon, label, widget.activeTab == label);
                }).toList(),
          ),
        ),
      ),
    );
  }
}
