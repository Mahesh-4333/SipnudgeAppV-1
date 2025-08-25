import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool isRed;
  final VoidCallback onTap;

  const ProfileMenuItemWidget({
    super.key,
    required this.iconPath,
    required this.title,
    this.isRed = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLogout = title == 'Logout';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 22.w,
              height: 22.h,
              color: isLogout ? const Color(0xFFF75555) : Colors.white,
              errorBuilder:
                  (_, __, ___) =>
                      Icon(Icons.error, color: Colors.redAccent, size: 22.sp),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                color: isRed ? const Color(0xFFF75555) : Colors.white,
                fontFamily: 'urbanist-Bold',
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: Colors.white, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
