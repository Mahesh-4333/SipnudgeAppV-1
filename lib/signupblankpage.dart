import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/otpscreen.dart';

class SignUpBlankPage extends StatefulWidget {
  const SignUpBlankPage({super.key});

  @override
  State<SignUpBlankPage> createState() => _SignUpBlankPage();
}

class _SignUpBlankPage extends State<SignUpBlankPage>
    with SingleTickerProviderStateMixin {
  bool _isChecked = false;
  bool _obscurePassword = true;
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OtpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 20.w, top: 30.h),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30.sp,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          Text(
                            'Get started with SipNudge ✨',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontFamily: 'MuseoModerno-Bold',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Create an account to track your water intake, set reminders, and unlock achievements.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'MuseoModerno-Regular',
                            ),
                          ),
                          SizedBox(height: 24.h),
                          _buildLabel('Email'),
                          SizedBox(height: 8.h),
                          _buildInputField(
                            _emailController,
                            'Email',
                            'assets/email.png',
                            false,
                          ),
                          SizedBox(height: 16.h),
                          _buildLabel('Password'),
                          SizedBox(height: 8.h),
                          _buildPasswordField(),
                          SizedBox(height: 12.h),
                          _buildTermsAndConditions(),
                          SizedBox(height: 16.h),
                          _buildSignInText(),
                          SizedBox(height: 16.h),
                          _buildDividerWithOr(),
                          SizedBox(height: 16.h),
                          _buildSocialButton(
                            asset: 'assets/apple.png',
                            text: 'Continue with Apple',
                            color: Color(0xFFC89DE9),
                          ),
                          SizedBox(height: 16.h),
                          _buildSocialButton(
                            asset: 'assets/google.png',
                            text: 'Continue with Google',
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading) _buildLoadingDialog(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontFamily: 'Urbanist-SemiBold',
        shadows: [
          Shadow(
            offset: Offset(0, 2.h),
            blurRadius: 2.r,
            color: Color(0x40000000),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String hint,
    String icon,
    bool obscureText,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(1000.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(4.w, 4.h),
            blurRadius: 4.r,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 16.w,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Image.asset(icon, width: 18.w, height: 16.h),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000.r),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Urbanist-Regular',
            color: Color(0xFF1D1D1D),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(1000.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(4.w, 4.h),
            blurRadius: 4.r,
          ),
        ],
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 16.w,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Image.asset('assets/lock.png', width: 18.w, height: 16.h),
          ),
          suffixIcon: IconButton(
            icon: Image.asset(
              _obscurePassword
                  ? 'assets/viewpasswordoff.png'
                  : 'assets/viewpassword.png',
              width: 20.w,
              height: 20.h,
              color: Colors.black,
            ),
            onPressed:
                () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000.r),
            borderSide: BorderSide.none,
          ),
          hintText: 'Password',
          hintStyle: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Urbanist-Regular',
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Transform.scale(
          scale: 1.4,
          child: Checkbox(
            value: _isChecked,
            onChanged: (value) => setState(() => _isChecked = value!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            side: BorderSide(width: 2.5.w, color: Color(0xFF53C1BC)),
            checkColor: Colors.white,
            activeColor: Color(0xFF53C1BC),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I agree to Sipnudge ',
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: 'Urbanist-Medium',
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: 'T&C. ',
                  style: TextStyle(
                    color: Color(0xFF369FFF),
                    fontSize: 17.sp,
                    fontFamily: 'Urbanist-Medium',
                  ),
                ),
                TextSpan(
                  text: 'click to continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontFamily: 'Urbanist-Medium',
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _handleSignUp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Urbanist-Regular',
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/signin'),
          child: Text(
            'Sign in',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Urbanist-SemiBold',
              color: Color(0xFF369FFF),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDividerWithOr() {
    return Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFE9E9E9))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'or',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Urbanist-Medium',
              color: Color(0xFF616161),
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFE9E9E9))),
      ],
    );
  }

  Widget _buildSocialButton({
    required String asset,
    required String text,
    Color? color,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4.h),
            blurRadius: 2.r,
          ),
        ],
        borderRadius: BorderRadius.circular(1000.r),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFE9E9E9),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(asset, width: 24.w, height: 24.h, color: color),
            SizedBox(width: 56.w),
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF212121),
                fontFamily: 'Urbanist-Bold',
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingDialog() {
    return Center(
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Color(0xFF1F222A),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: CustomPaint(
                  painter: _LoadingPainter(_animationController),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Sign up...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontFamily: 'MuseoModerno-SemiBold',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingPainter extends CustomPainter {
  final Animation<double> animation;
  _LoadingPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 10.w;
    final center = Offset(size.width / 2, size.height / 2);
    final ringRadius = (size.shortestSide / 2) - strokeWidth / 2;

    final blackPaint =
        Paint()
          ..color = Color(0xFF1F222A)
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, ringRadius - strokeWidth / 2, blackPaint);

    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 2 * math.pi,
      colors: [
        Color(0xFFB586BE),
        Color(0xFF8A5A9B),
        Color(0xFF4E2E58),
        Color(0xFF1A0E1E),
      ],
      stops: [0.0, 0.3, 0.6, 1.0],
      transform: GradientRotation(animation.value * 2 * math.pi),
    );

    final ringPaint =
        Paint()
          ..shader = gradient.createShader(
            Rect.fromCircle(center: center, radius: ringRadius),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, ringRadius, ringPaint);

    final angle = 2 * math.pi * animation.value;
    final dotX = center.dx + ringRadius * math.cos(angle);
    final dotY = center.dy + ringRadius * math.sin(angle);

    final dotPaint =
        Paint()
          ..color = Color(0xFF1A0E1E)
          ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(dotX, dotY), 6.r, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _LoadingPainter oldDelegate) => true;
}
