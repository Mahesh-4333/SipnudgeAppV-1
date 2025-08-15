// lib/widgets/cycle_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CycleItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const CycleItem({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: 'Urbanist-SemiBold',
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA).withOpacity(0.25),
                border: Border.all(color: const Color(0xFFFFFFFF), width: 1.w),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: 16.sp,
                  fontFamily: 'Urbanist-SemiBold',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
