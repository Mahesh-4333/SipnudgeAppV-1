import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';
import 'package:flutterapp1/constants/app_dimensions.dart';
import 'package:flutterapp1/constants/app_font_styles.dart';

class NavItemWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required Null Function() onTab,
  });

  @override
  State<NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<NavItemWidget> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final assetPath = 'assets/${widget.label.toLowerCase()}.png';
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.9),
      onTapUp: (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppDimensions.dim86.w,
              height: AppDimensions.dim59.h,
              // width: screenWidth * 0.2,
              // height: screenHeight * 0.06,
              decoration: BoxDecoration(
                gradient:
                    widget.isActive
                        ? const LinearGradient(
                          colors: [AppColors.alabaster, AppColors.iridium],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                        : null,
                color: widget.isActive ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(AppDimensions.dim48.r),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 4),
                    color:
                        widget.isActive
                            ? AppColors.black40
                            : Colors.transparent,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.dim1),
                child: Container(
                  width: AppDimensions.dim82.w,
                  height: AppDimensions.dim51.h,
                  // width: screenWidth * 0.19,
                  // height: screenHeight * 0.055,
                  decoration: BoxDecoration(
                    gradient:
                        widget.isActive
                            ? const LinearGradient(
                              colors: [
                                AppColors.navbarSelectedItemGradientStart,
                                AppColors.navbarSelectedItemGradientEnd,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                            : null,
                    color: widget.isActive ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radius_46.r,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        assetPath,
                        width: AppDimensions.dim26.w,
                        height: AppDimensions.dim26.h,
                        // width: screenWidth * 0.06,
                        // height: screenWidth * 0.06,
                        color: AppColors.white,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint(
                            'Error loading image: $assetPath - $error',
                          );
                          return Icon(
                            widget.icon,
                            size: AppFontStyles.fontSize_24.sp,
                            // size: screenWidth * 0.055,
                            color: AppColors.white,
                          );
                        },
                      ),
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppFontStyles.fontSize_13.sp,
                          // fontSize: screenWidth * 0.03,
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
  }
}
