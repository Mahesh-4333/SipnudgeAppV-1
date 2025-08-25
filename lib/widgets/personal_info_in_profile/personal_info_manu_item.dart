// widgets/menu_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String info;
  final VoidCallback? onTap;
  final bool isRed;

  const MenuItem({
    super.key,
    required this.title,
    required this.info,
    this.onTap,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            Text(
              info,
              style: TextStyle(
                color: isRed ? Colors.redAccent : Colors.white,
                fontFamily: 'urbanist-SemiBold',
                fontSize: 16.sp,
              ),
            ),
            const SizedBox(width: 15),
            Icon(Icons.chevron_right, color: Colors.white, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
