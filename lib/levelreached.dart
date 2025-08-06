import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showLevelUpDialog(BuildContext context, int level, String totalLitres) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 80.h),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            image: DecorationImage(
              image: AssetImage('assets/popupscreenimage.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Badge with Gradient Level Number
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/achievmentimage.png',
                          width: 330.w,
                          height: 320.h,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 36.w),
                          child: ShaderMask(
                            shaderCallback:
                                (bounds) => const LinearGradient(
                                  colors: [
                                    Color(0xFF8C41FD),
                                    Color(0xFF7800BD),
                                    Color(0xFFAE58E0),
                                    Color(0xFFA66CFD),
                                  ],
                                ).createShader(
                                  Rect.fromLTWH(
                                    0,
                                    0,
                                    bounds.width,
                                    bounds.height,
                                  ),
                                ),
                            blendMode: BlendMode.srcIn,
                            child: Transform.translate(
                              offset: Offset(0, -5.h),
                              child: Text(
                                '$level',
                                style: TextStyle(
                                  fontSize: 74.sp,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'poppins-Bold',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 25.w, top: 230.h),
                          child: Text(
                            "You've Reached Level $level!",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'urbanist-bold',
                              color: Color(0xFF121212),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                /// Title
                // Text(
                //   "You've Reached Level $level!",
                //   style: TextStyle(
                //     fontSize: 24.sp,
                //     fontWeight: FontWeight.w700,
                //     fontFamily: 'urbanist-bold',
                //     color: Color(0xFF121212),
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: 10.h),

                /// Message
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    '"Way to go! Your $totalLitres water goal is complete. Keep the good habits flowing!"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0x40000000),
                      fontFamily: 'urbanist-medium',
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    'Share your achievements with friends',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0x50121212),
                      fontFamily: 'urbanist-medium',
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                /// Share Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Replace with share logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF369FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Share',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontFamily: 'urbanist-semibold',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
