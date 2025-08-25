import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpMenuItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isRed;

  const HelpMenuItem({
    super.key,
    required this.title,
    required this.route,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isRed ? Colors.redAccent : Colors.white,
                fontFamily: 'urbanist-Bold',
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
