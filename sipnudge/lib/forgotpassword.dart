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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Header
                      Text(
                        'Forgot Your Password? 🔑',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontFamily: 'MuseoModerno-Bold',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No worries! Enter your registered email\nbelow to reset your password.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: screenWidth * 0.042,
                          fontFamily: 'MuseoModerno-Regular',
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Email Field
                      Text(
                        'Your Registered Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
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
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                          decoration: InputDecoration(
                            fillColor: const Color(0xFFFFFFFF),
                            filled: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Image.asset(
                                'assets/email.png',
                                width: 18,
                                height: 16,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1000),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'abc@gmail.com',
                            hintStyle: TextStyle(
                              fontSize: screenWidth * 0.045,
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

              // Fixed Bottom Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(0, 4),
                        blurRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/otppage');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: const Color(0xFF369FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Send OTP Code',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Urbanist-Bold',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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
