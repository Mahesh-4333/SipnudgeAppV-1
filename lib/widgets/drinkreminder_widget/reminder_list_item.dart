import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReminderListItem extends StatelessWidget {
  final String title;
  final String trailing;
  final VoidCallback onTap;
  final bool showCapsule;

  const ReminderListItem({
    super.key,
    required this.title,
    required this.trailing,
    required this.onTap,
    this.showCapsule = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
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
            if (showCapsule)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Text(
                  trailing,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'Urbanist-Medium',
                  ),
                ),
              )
            else
              Row(
                children: [
                  if (trailing.isNotEmpty)
                    Text(
                      trailing,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Urbanist-SemiBold',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  SizedBox(width: 8.w),
                  Icon(Icons.chevron_right, color: Colors.white, size: 20.sp),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
