import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordUpdatedScreen extends StatefulWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  State<PasswordUpdatedScreen> createState() => _PasswordUpdatedScreenState();
}

class _PasswordUpdatedScreenState extends State<PasswordUpdatedScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB586BE), Color(0xFF131313)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // Back Arrow Positioned at the Top Left
                  Positioned(
                    top: 30.h,
                    left: 24.w,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),

                  // Main Column Content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 200.h), // Space below back arrow

                        // Center Image
                        Center(
                          child: Container(
                            width: 200.w,
                            height: 160.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/mobile1.png',
                                width: 200.w,
                                height: 200.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            "You're All Set!",
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontFamily: 'MuseoModerno-Bold',
                              color: Color(0xFFE7D7FF),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        Center(
                          child: Text(
                            "Your password has been successfully\nupdated.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'MuseoModerno-Regular',
                              color: Color(0xFFDCDCDC),
                            ),
                          ),
                        ),
                        const Spacer(),

                        // Go to Homepage Button
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000.r),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(4, 4),
                                blurRadius: 4,
                                color: Color(0x40000000)
                              )
                            ]
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Navigate to homepage
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF369FFF),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1000.r),
                              ),
                            ),
                            child: Text(
                              'Go to Homepage',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16.sp,
                                fontFamily: 'Urbanist-Bold',
                                //fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
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
}
