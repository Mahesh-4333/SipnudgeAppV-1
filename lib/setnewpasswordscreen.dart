import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    //final double screenHeight = screenSize.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB586BE), Color(0xFF131313)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.09,
              top: screenWidth * 0.09,
              right: screenWidth * 0.07,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Arrow
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF000000)),
                ),
                SizedBox(height: 20.h),

                // Title
                Text(
                  'Secure Your Account 🔒',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                    fontFamily: 'MuseoModerno-Bold',
                  ),
                ),
                SizedBox(height: 12.h),

                // Subtitle
                Text(
                  'Choose a new password for your Sipnudge account. Make sure it\'s strong and memorable.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.035,
                    fontFamily: 'MuseoModerno-Regular',
                  ),
                ),
                SizedBox(height: 32.h),

                // New Password Field
                Text(
                  'New Password',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 18.sp,
                    fontFamily: 'Urbanist-SemiBold',
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 6,
                        color: Color(0xFF000000)
                      )
                    ]
                  ),
                ),
                SizedBox(height: 8.h),
                _buildPasswordField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  onToggle: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
                SizedBox(height: 24.h),

                // Confirm Password Field
                Text(
                  'Confirm New Password',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 18.sp,
                    fontFamily: 'Urbanist-SemiBold',
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 6,
                        color: Color(0xFF000000)
                      )
                    ]
                  ),
                ),
                SizedBox(height: 8.h),
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  onToggle: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                const Spacer(),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/newpasswordupdate');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF369FFF),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                    ),
                    child: Text(
                      'Save New Password',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16.sp,
                        fontFamily: 'Urbanist-Medium',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.52),
            offset: const Offset(4, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child:  Image.asset('assets/lock.png'),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: const TextStyle(
                fontFamily: 'Urbanist-Medium',
                fontWeight: FontWeight.w500,
                //fontSize: 12,
                color: Colors.black),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '●●●●●●●●●●●●',
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Urbanist-Medium',
                  //fontWeight: FontWeight.w500,
                  color: Color(0xFF060606)),
              ),
              cursorColor: Colors.black,
            ),
          ),
          Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: IconButton(
            icon: Image.asset(
                       obscureText
                        ? 'assets/viewpasswordoff.png'
                          : 'assets/viewpassword.png',
                            width: 20,
                            height: 20,
                            color: const Color(0xFF000000),
                                ),
            onPressed: onToggle,
          )
          ),
        ],
      ),
    );
  }
}
