import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    // Reusable sizes
    final double horizontalPadding = screenWidth * 0.06;
    final double verticalSpacing = screenHeight * 0.02;
    final double inputFieldHeight = screenHeight * 0.055; // Decreased height
    final double fontSizeTitle = screenWidth * 0.055;
    final double fontSizeSub = screenWidth * 0.043;
    final double fontSizeHint = screenWidth * 0.045;
    final double buttonFontSize = screenWidth * 0.045;
    final double buttonHeight = screenHeight * 0.06; // Decreased height

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
          child: Column(
            children: [
              // Back Button
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  top: screenHeight * 0.04,
                  bottom: screenHeight * 0.01,
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Color(0xFF212121),
                  ),
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalSpacing,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Text
                      Text(
                        'Forgot Your Password? 🔑',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeTitle,
                          fontFamily: 'MuseoModerno-Bold',
                        ),
                      ),
                      SizedBox(height: verticalSpacing),
                      Text(
                        'No worries! Enter your registered email\nbelow to reset your password.',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: fontSizeSub,
                          fontFamily: 'MuseoModerno-Regular',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.045),

                      // Email Label
                      Text(
                        'Your Registered Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeHint,
                          fontFamily: 'MuseoModerno-Bold',
                          shadows: const [
                            Shadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Color(0x40000000),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      // Email Field
                      Container(
                        height: inputFieldHeight,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(1000),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Color(0x40000000),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: fontSizeHint,
                            fontFamily: 'MuseoModerno-Regular',
                            color: Color(0xFF212121),
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFAFAFA),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                              child: Image.asset(
                                'assets/email.png',
                                width: screenWidth * 0.05,
                                height: screenHeight * 0.025,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1000),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'abc@gmail.com',
                            hintStyle: TextStyle(
                              fontSize: fontSizeHint,
                              fontFamily: 'MuseoModerno-Bold',
                              color: const Color(0xFF1D1D1D),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Button
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  screenHeight * 0.03,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgotpasswordotp');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: const Color(0xFF369FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),
                    child: Text(
                      'Send OTP Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Urbanist-Bold',
                        fontWeight: FontWeight.bold,
                        fontSize: buttonFontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
