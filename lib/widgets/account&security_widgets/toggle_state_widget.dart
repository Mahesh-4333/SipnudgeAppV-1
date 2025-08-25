import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const ToggleTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFFFFFFFF),
            fontSize: 18.sp,
            fontFamily: 'urbanist-Bold',
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: const Color(0xFFB586BE),
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color(0x90FFFFFF),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
