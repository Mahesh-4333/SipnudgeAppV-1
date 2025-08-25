import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemTile extends StatelessWidget {
  final String title;
  final String info;

  const MenuItemTile({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => debugPrint("Tapped $title"),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontFamily: 'urbanist-Bold',
              ),
            ),
            const Spacer(),
            Text(
              info,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'urbanist-SemiBold',
              ),
            ),
            SizedBox(width: 15.w),
            Icon(Icons.chevron_right, color: Colors.white, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
