import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  bool _isChecked = false;
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
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
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  Future<void> _handleSignIn() async {
    final password = _passwordController.text;

    if (!_isPasswordStrong(password)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Weak Password',
              style: TextStyle(
                  fontFamily: 'Urbanist-Bold',
                  fontSize: 16,
                  color: Color(0xFF000000)),
            ),
            content: const Text(
              'Password must be at least 8 characters long, include uppercase, lowercase, number, and special character.',
              style: TextStyle(
                  fontFamily: 'Urbanist-Regular',
                  fontSize: 14,
                  color: Color(0xFF000000)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Ok',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Urbanist-Bold',
                      color: Color(0xFF000000)),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

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

    Navigator.pushNamed(context, '/otpscreen');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

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
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.09,
              vertical: screenHeight * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,
                      color: Color(0xFF212121), size: 30),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Glad to see you again! 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                    fontFamily: 'MuseoModerno-Bold',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Sign in to your account to continue your\njourney towards a healthier you.',
                  style: TextStyle(
                    color: const Color(0xFFFDFDFD),
                    fontSize: screenWidth * 0.040,
                    fontFamily: 'MuseoModerno-Regular',
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildLabel(screenWidth, 'Email'),
                const SizedBox(height: 8),
                _buildInputField(
                    'assets/email.png', 'Email', _emailController),
                SizedBox(height: screenHeight * 0.03),
                _buildLabel(screenWidth, 'Password'),
                const SizedBox(height: 8),
                _buildInputField('assets/lock.png', 'Password',
                    _passwordController,
                    obscureText: _obscurePassword,
                    isPassword: true),

                SizedBox(height: screenHeight * 0.013),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          side: const BorderSide(
                              width: 2.5, color: Color(0xFF53C1BC)),
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Urbanist-Medium',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgotpassword');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontFamily: 'Urbanist-Medium',
                          color: const Color(0xFF369FFF),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(child: Divider(color: Color(0xFFE9E9E9))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: screenWidth * 0.042,
                          fontFamily: 'Urbanist-Medium',
                          color: const Color(0xFF616161),
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: Color(0xFFE9E9E9))),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                buildPrimaryButton('Sign In', const Color(0xFF93C8FC),
                    const Color(0xFF4C3F57), _handleSignIn),

                SizedBox(height: screenHeight * 0.025),
                buildSocialButton(
                  iconPath: 'assets/apple.png',
                  label: 'Continue with Apple',
                  iconColor: const Color(0xFFC89DE9),
                  onPressed: () {
                    Navigator.pushNamed(context, '/personalinfo');
                  },
                ),
                SizedBox(height: screenHeight * 0.025),
                buildSocialButton(
                  iconPath: 'assets/google.png',
                  label: 'Continue with Google',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(double screenWidth, String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: screenWidth * 0.045,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0x40000000)),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Image.asset(iconPath, width: 18, height: 16),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Image.asset(
                    obscureText ? 'assets/viewpasswordoff.png' : 'assets/viewpassword.png',
                    color: const Color(0xFF000000),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 18,
            fontFamily: 'Urbanist-Regular',
            color: Color(0xFF1D1D1D),
          ),
        ),
      ),
    );
  }

  Widget buildPrimaryButton(String label, Color bgColor, Color textColor,
      VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
              fontWeight: FontWeight.bold,
              fontSize: 16,
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(iconPath, width: 24, height: 24, color: iconColor),
            const SizedBox(width: 65),
            Text(
              label,
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
