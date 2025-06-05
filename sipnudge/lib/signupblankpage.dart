import 'package:flutter/material.dart';

class SignUpBlankPage extends StatefulWidget {
  const SignUpBlankPage({super.key});

  @override
  State<SignUpBlankPage> createState() => _SignUpBlankPage();
}

class _SignUpBlankPage extends State<SignUpBlankPage> {
  bool _isChecked = false;
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.04),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, size: 30, color: Color(0xFF212121)),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Header
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
                        color: Colors.white.withOpacity(0.95),
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'MuseoModerno-Regular',
                        letterSpacing: 0.0,
                      ),
                    ),
                SizedBox(height: screenHeight * 0.03),

                // Email Input
                Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1000),
                    boxShadow: const [
                      BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0x40000000)),
                    ],
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 8),
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

                SizedBox(height: screenHeight * 0.03),

                // Password Input
                Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.white,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1000),
                    boxShadow: const [
                      BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0x40000000)),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 8),
                        child: Image.asset('assets/lock.png', width: 18, height: 16),
                      ),
                      suffixIcon: IconButton(
                        icon: Image.asset(
                          _obscurePassword ? 'assets/viewpasswordoff.png' : 'assets/viewpassword.png',
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

                SizedBox(height: screenHeight * 0.015),

                // Checkbox and Terms
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                      side: const BorderSide(width: 2.5, color: Color(0xFF53C1BC)),
                    ),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          text: 'I agree to Sipnudge ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Urbanist-Medium',
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions.',
                              style: TextStyle(
                                color: Color(0xFF365DFF),
                                fontFamily: 'Urbanist-Medium',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.01),

                // Already have an account
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

                const SizedBox(height: 8),

                // Divider
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

                // Apple Button
                _buildSocialButton(
                  asset: 'assets/apple.png',
                  text: 'Continue with Apple',
                  color: const Color(0xFFC89DE9),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Google Button
                _buildSocialButton(
                  asset: 'assets/google.png',
                  text: 'Continue with Google',
                ),

                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String asset, required String text, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 2),
        ],
        borderRadius: BorderRadius.circular(1000),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Implement social sign-in logic
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
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
