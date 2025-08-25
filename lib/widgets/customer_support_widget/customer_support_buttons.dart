import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onPressed;
  final Color? iconColor;

  const SupportButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x40000000),
            offset: Offset(4.r, 4.r),
            blurRadius: 4.r,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.r),
          ),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24.w, height: 24.w, color: iconColor),
            SizedBox(width: 16.w),
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF212121),
                fontFamily: 'Urbanist-Bold',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: Colors.black, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
