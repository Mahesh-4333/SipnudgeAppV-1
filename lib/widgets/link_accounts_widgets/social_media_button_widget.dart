import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSocialButton({
  required String iconPath,
  required String label,
  required String label1,
  Color? iconColor,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1000.r),
      boxShadow: [
        BoxShadow(
          color: const Color(0x40000000),
          offset: Offset(0, 4.h), // vertical offset responsive
          blurRadius: 6.r, // blur radius responsive
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Icon
          Image.asset(iconPath, width: 35.w, height: 35.w, color: iconColor),

          SizedBox(width: 46.w),

          /// Label
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF212121),
              fontFamily: 'Urbanist-Bold',
              fontSize: 18.sp,
            ),
          ),

          const Spacer(),

          /// Connect/Connected Label
          Text(
            label1,
            style: TextStyle(
              color: const Color(0xFF212121),
              fontFamily: 'Urbanist-Bold',
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    ),
  );
}
