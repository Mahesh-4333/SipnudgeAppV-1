import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp1/otpscreen.dart';

class SignUpBlankPage extends StatefulWidget {
  const SignUpBlankPage({super.key});

  @override
  State<SignUpBlankPage> createState() => _SignUpBlankPage();
}

class _SignUpBlankPage extends State<SignUpBlankPage> with SingleTickerProviderStateMixin {
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
    
    // Simulate an API call or any async operation
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
    });
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OtpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                    padding: EdgeInsets.only(left: screenWidth * 0.06, top: screenHeight * 0.05),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, size: 30, color: Color(0xFF212121)),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            'Get started with SipNudge ✨',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.05,
                              fontFamily: 'MuseoModerno-Bold',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Create an account to track your water intake, set reminders, and unlock achievements.',
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: screenWidth * 0.037,
                              fontFamily: 'MuseoModerno-Regular',
                              letterSpacing: 0.1,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: screenWidth * 0.045,
                              fontFamily: 'Urbanist-SemiBold',
                              shadows: const [
                                Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0x40000000))
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(1000),
                              boxShadow: const [
                                BoxShadow(offset: Offset(4, 4), blurRadius: 4, color: Color(0x40000000)),
                              ],
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 8),
                                  child: Image.asset('assets/email.png', width: 18, height: 16),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1000),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontFamily: 'Urbanist-Regular',
                                  color: const Color(0xFF1D1D1D),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: screenWidth * 0.045,
                              fontFamily: 'Urbanist-SemiBold',
                              shadows: const [
                                Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0x40000000))
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(1000),
                              boxShadow: const [
                                BoxShadow(offset: Offset(4, 4), blurRadius: 4, color: Color(0x40000000)),
                              ],
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: Image.asset('assets/lock.png', width: 18, height: 16),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Image.asset(
                                      _obscurePassword
                                          ? 'assets/viewpasswordoff.png'
                                          : 'assets/viewpassword.png',
                                      width: 20,
                                      height: 20,
                                      color: const Color(0xFF000000),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1000),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontFamily: 'Urbanist-Regular',
                                  color: const Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.012),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                                  side: const BorderSide(width: 2.5, color: Color(0xFF53C1BC)),
                                  checkColor: Colors.white,
                                  activeColor: const Color(0xFF53C1BC),
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I agree to Sipnudge ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Urbanist-Medium',
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'T&C. ',
                                        style: TextStyle(
                                          color: Color(0xFF369FFF),
                                          fontSize: 16,
                                          fontFamily: 'Urbanist-Medium',
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'click to continue',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Urbanist-Medium',
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            _handleSignUp();
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Urbanist-Regular',
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signin');
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Urbanist-SemiBold',
                                    color: Color(0xFF369FFF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //const SizedBox(height: 2),
                          Row(
                            children: [
                              const Expanded(child: Divider(color: Color(0xFFE9E9E9))),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontFamily: 'Urbanist-Medium',
                                    color: const Color(0xFF616161),
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider(color: Color(0xFFE9E9E9))),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          _buildSocialButton(
                            asset: 'assets/apple.png',
                            text: 'Continue with Apple',
                            color: const Color(0xFFC89DE9),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildSocialButton(
                            asset: 'assets/google.png',
                            text: 'Continue with Google',
                          ),
                          SizedBox(height: screenHeight * 0.04),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Loading overlay
            if (_isLoading)
              Center(
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F222A),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CustomPaint(
                            painter: _LoadingPainter(_animationController),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Sign up...',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'MuseoModerno-SemiBold',
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String asset, required String text, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Color(0x40000000), offset: const Offset(0, 4), blurRadius: 2),
        ],
        borderRadius: BorderRadius.circular(1000),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Implement social sign-in logic
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE9E9E9),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(asset, width: 24, height: 24, color: color),
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
}

class _LoadingPainter extends CustomPainter {
  final Animation<double> animation;

  _LoadingPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 10.0;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (rect.shortestSide - strokeWidth) / 2;

    // Create a gradient that matches the image
    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 2.5 * math.pi,
      colors: const [
        Color(0xFFB586BE),  // Light purple
        Color(0xFF8A5A9B),  // Medium purple
        Color(0xFF4E2E58),  // Darker purple
        Color(0xFF1A0E1E),  // Very dark purple/black
        Color(0xFFB586BE),  // Back to light purple
      ],
      stops: const [0.0, 0.3, 0.6, 0.9, 1.0],
      transform: GradientRotation(animation.value * 2 * math.pi),
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw the full circle with the gradient
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _LoadingPainter oldDelegate) => true;
}
