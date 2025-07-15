import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> with TickerProviderStateMixin {
  bool _isChecked = false;
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isPasswordInvalid = false;

  late final AnimationController _animationController;
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 8,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);

    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _shakeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email') ?? '';
    final savedPassword = prefs.getString('saved_password') ?? '';
    final rememberMe = prefs.getBool('remember_me') ?? false;

    if (rememberMe) {
      _emailController.text = savedEmail;
      _passwordController.text = savedPassword;
    }

    setState(() {
      _isChecked = rememberMe;
    });
  }

  bool _isPasswordStrong(String password) {
    final regex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return regex.hasMatch(password);
  }

  Future<void> _handleSignIn() async {
    final password = _passwordController.text;

    if (!_isPasswordStrong(password)) {
      setState(() {
        _isPasswordInvalid = true;
      });
      _shakeController.forward(from: 0);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Weak Password',
              style: TextStyle(
                fontFamily: 'Urbanist-Bold',
                fontSize: 16.sp,
                color: Color(0xFF000000),
              ),
            ),
            content: Text(
              'Password must be at least 8 characters long, include uppercase, lowercase, number, and special character.',
              style: TextStyle(
                fontFamily: 'Urbanist-Regular',
                fontSize: 14.sp,
                color: Color(0xFF000000),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Urbanist-Bold',
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      _isPasswordInvalid = false;
      _isLoading = true;
    });

    // Simulate an API call or any async operation.
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Reduced from 20 to 2 seconds for better UX

    final prefs = await SharedPreferences.getInstance();
    if (_isChecked) {
      await prefs.setString('saved_email', _emailController.text);
      await prefs.setString('saved_password', password);
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
      await prefs.setBool('remember_me', false);
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.pushNamed(context, '/personalinfo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: const Color(0xFF212121),
                        size: 30.sp,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Glad to see you again! 👋',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 24.sp,
                              fontFamily: 'MuseoModerno-Bold',
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Sign in to your account to continue your\njourney towards a healthier you.',
                            style: TextStyle(
                              color: const Color(0xFFFDFDFD),
                              fontSize: 18.sp,
                              fontFamily: 'MuseoModerno-Regular',
                            ),
                          ),
                          SizedBox(height: 24.h),
                          _buildLabel('Email'),
                          SizedBox(height: 8.h),
                          _buildInputField(
                            'assets/email.png',
                            'Email',
                            _emailController,
                          ),
                          SizedBox(height: 20.h),
                          _buildLabel('Password'),
                          SizedBox(height: 8.h),
                          _buildInputField(
                            'assets/lock.png',
                            'Password',
                            _passwordController,
                            obscureText: _obscurePassword,
                            isPassword: true,
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.3,
                                    child: Checkbox(
                                      value: _isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked = value ?? false;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      side: const BorderSide(
                                        width: 2.5,
                                        color: Color(0xFF53C1BC),
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: const Color(0xFF53C1BC),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontFamily: 'Urbanist-Medium',
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/forgotpassword',
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: 'Urbanist-SemiBold',
                                    color: const Color(0xFF369FFF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          buildPrimaryButton(
                            'Sign In',
                            const Color(0xFF93C8FC),
                            const Color(0xFF4C3F57),
                            _isLoading ? null : _handleSignIn,
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(color: Color(0xFFE9E9E9)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.w),
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: 'Urbanist-Medium',
                                    color: const Color(0xFF616161),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(color: Color(0xFFE9E9E9)),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          buildSocialButton(
                            iconPath: 'assets/apple.png',
                            label: 'Continue with Apple',
                            iconColor: const Color(0xFFC89DE9),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Preferences');
                            },
                          ),
                          SizedBox(height: 16.h),
                          buildSocialButton(
                            iconPath: 'assets/google.png',
                            label: 'Continue with Google',
                            onPressed: () {
                              Navigator.pushNamed(context, '/profilescreen');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Center(
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F222A),
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
                        'Sign in...',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'MuseoModerno-SemiBold',
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18.sp,
        fontFamily: 'Urbanist-SemiBold',
        shadows: const [
          Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0x40000000)),
        ],
      ),
    );
  }

  Widget _buildInputField(
    String iconPath,
    String hintText,
    TextEditingController controller, {
    bool obscureText = false,
    bool isPassword = false,
  }) {
    bool showRedBorder = isPassword && _isPasswordInvalid;
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000.r),
        border: Border.all(
          color: showRedBorder ? Color(0xFFFE4848) : Colors.transparent,
          width: 2.w,
        ),
      ),
      child:
          isPassword
              ? AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      _isPasswordInvalid
                          ? _shakeAnimation.value *
                              math.sin(
                                DateTime.now().millisecondsSinceEpoch / 50,
                              )
                          : 0,
                      0,
                    ),
                    child: child,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000.r),
                  child: TextFormField(
                    controller: controller,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFFAFAFA),
                      filled: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 21.w, right: 12.w),
                        child: Image.asset(iconPath, width: 16.w, height: 16.h),
                      ),
                      suffixIcon:
                          isPassword
                              ? Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: IconButton(
                                  icon: Image.asset(
                                    obscureText
                                        ? 'assets/viewpasswordoff.png'
                                        : 'assets/viewpassword.png',
                                    color: const Color(0xFF000000),
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              )
                              : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1000.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 16.w,
                      ),
                      hintText: hintText,
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Urbanist-Regular',
                        color: const Color(0xFF1D1D1D),
                      ),
                    ),
                  ),
                ),
              )
              : TextFormField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFFAFAFA),
                  filled: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 21.w, right: 12.w),
                    child: Image.asset(iconPath, width: 16.w, height: 16.h),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1000.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 16.w,
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Urbanist-Regular',
                    color: const Color(0xFF1D1D1D),
                  ),
                ),
              ),
    );
  }

  Widget buildPrimaryButton(
    String label,
    Color bgColor,
    Color textColor,
    VoidCallback? onPressed,
  ) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: const Offset(0, 4),
            blurRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: bgColor,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontFamily: 'Urbanist-Bold',
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSocialButton({
    required String iconPath,
    required String label,
    Color? iconColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: const Offset(0, 4),
            blurRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(iconPath, width: 24.w, height: 24.h, color: iconColor),
            SizedBox(width: 65.w),
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF212121),
                fontFamily: 'Urbanist-Bold',
                fontSize: 16.sp,
              ),
            ),
          ],
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

    final outerRadius = (size.shortestSide) / 2;
    final ringRadius = outerRadius - strokeWidth / 2;
    final innerRadius = outerRadius - strokeWidth;

    // Step 1: Draw inner black filled circle
    final blackPaint =
        Paint()
          ..color = const Color(0xFF1F222A)
          ..style = PaintingStyle.fill;

    canvas.drawCircle(center, innerRadius, blackPaint);

    // Create a gradient that matches the image
    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 2.0 * math.pi,
      colors: const [
        Color(0xFFB586BE), // Start Light Purple
        Color(0xFF8A5A9B),
        Color(0xFF4E2E58),
        Color(0xFF1A0E1E), // End Deep Purple, flows continuously
      ],
      stops: const [0.0, 0.3, 0.6, 1.0],
      transform: GradientRotation(animation.value * 2 * math.pi),
    );

    final ringPaint =
        Paint()
          ..shader = gradient.createShader(
            Rect.fromCircle(center: center, radius: ringRadius),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, ringRadius, ringPaint);

    // Step 3: Draw small white circle at the end
    final angle = 2 * math.pi * animation.value;
    final endX = center.dx + ringRadius * math.cos(angle);
    final endY = center.dy + ringRadius * math.sin(angle);

    final whiteDotPaint =
        Paint()
          ..color = Color(0xFF1A0E1E)
          ..style = PaintingStyle.fill;

    const dotRadius = 6.0;
    canvas.drawCircle(Offset(endX, endY), dotRadius, whiteDotPaint);
  }

  @override
  bool shouldRepaint(covariant _LoadingPainter oldDelegate) => true;
}

class GradientLoadingSpinner extends StatefulWidget {
  const GradientLoadingSpinner({super.key});

  @override
  State<GradientLoadingSpinner> createState() => _GradientLoadingSpinnerState();
}

class _GradientLoadingSpinnerState extends State<GradientLoadingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(160.w, 160.h),
      painter: _LoadingPainter(_controller),
    );
  }
}
