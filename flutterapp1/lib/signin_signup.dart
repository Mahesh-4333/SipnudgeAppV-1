import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn_SignUpPage extends StatefulWidget {
  const SignIn_SignUpPage({super.key});

  @override
  State<SignIn_SignUpPage> createState() => _SignIn_SignUpPage();
}

class _SignIn_SignUpPage extends State<SignIn_SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.1),
                          SizedBox(
                            width: 260.w,
                            height: 60.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  left: 4.0,
                                  top: 4.0,
                                  child: ImageFiltered(
                                    imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                    child: Image.asset(
                                      'assets/companylogo.png',
                                      width: 260.w,
                                      height: 60.h,
                                      fit: BoxFit.cover,
                                      color: Color(0x40000000),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'assets/companylogo.png',
                                  width: 260.w,
                                  height: 60.h,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'Begin your journey',
                            style: TextStyle(
                              fontSize: screenWidth * 0.08,
                              fontFamily: 'MuseoModerno-Bold',
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 3),
                                  blurRadius: 5,
                                  color: Color(0x40000000),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            "Let's dive in into your account",
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontFamily: 'MuseoModerno-Regular',
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 3),
                                  blurRadius: 5,
                                  color: Color(0x40000000),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.06),

                          buildSocialButton(context, 'assets/google.png', 'Continue with Google', () {}),
                          SizedBox(height: screenHeight * 0.025),
                          buildSocialButton(context, 'assets/apple.png', 'Continue with Apple', () {}),
                          SizedBox(height: screenHeight * 0.05),

                          buildActionButton(
                            context,
                            'Sign Up',
                            const Color(0xFF369FFF),
                            Colors.white,
                            () => Navigator.pushNamed(context, '/signupblankpage'),
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          buildActionButton(
                            context,
                            'Sign In',
                            const Color(0xFF93C8FC),
                            const Color(0xFF4C3F57),
                            () => Navigator.pushNamed(context, '/signin'),
                          ),
                          const Spacer(),

                          // Bottom Privacy & Terms Buttons
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Handle Privacy Policy tap
                                  },
                                  child: const Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Urbanist-Regular',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                TextButton(
                                  onPressed: () {
                                    // Handle Terms of Service tap
                                  },
                                  child: const Text(
                                    'Terms of Service',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Urbanist-Regular',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildSocialButton(BuildContext context, String iconPath, String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: const Offset(0, 4),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(1000),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 56),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontFamily: 'Urbanist-Bold',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActionButton(
    BuildContext context,
    String text,
    Color bgColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: const Offset(0, 4),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(1000),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Urbanist-Bold',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
