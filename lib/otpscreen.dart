import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreen();
}

class _OtpScreen extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  Timer? _timer;
  int _start = 60;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    for (var node in _focusNodes) {
      node.addListener(() => setState(() {}));
    }
  }

  void startTimer() {
    setState(() {
      _start = 60;
      _isResendEnabled = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendEnabled = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB586BE), Color(0xFF131313)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // Back button in its own container
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  top: screenHeight * 0.05,
                  bottom: screenHeight * 0.03,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Enter OTP Code',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'MuseoModerno-Bold',
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          SizedBox(width: 7),
                          Image.asset(
                            'assets/otp_lock1.png',
                            width: 24,
                            height: 24,
                            //color: Colors.transparent,
                          ),
                        ],
                      ),
                      /*const Text(
                        'Enter OTP Code 🔐',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'MuseoModerno-Bold',
                          color: Color(0xFFFFFFFF),
                        ),
                      ),*/
                      const SizedBox(height: 10),
                      const Text(
                        "We've sent an OTP code to your email. Please check your inbox and enter the code below.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'MuseoModerno-Regular',
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index < 3 ? 12.0 : 0.0,
                            ), // 10px gap except after last field
                            //padding: const EdgeInsets.only(right: 6.0),
                            child: _buildOTPField(index),
                          );
                        }),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'You can resend the code in ',
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Urbanist-Regular',
                              color: Color(0xFFFFFFFF),
                            ),
                            children: [
                              TextSpan(
                                text: '$_start',
                                style: const TextStyle(
                                  color: Color(0xFF53C1BC),
                                ),
                              ),
                              const TextSpan(
                                text: ' seconds',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Urbanist-Regular',
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: GestureDetector(
                          onTap:
                              _isResendEnabled
                                  ? () {
                                    startTimer();
                                    // logic to resend OTP
                                  }
                                  : null,
                          child: Text(
                            'Resend code',
                            style: TextStyle(
                              color:
                                  _isResendEnabled
                                      ? const Color(0xFF8BDEF3)
                                      : Colors.grey,
                              fontFamily: 'Urbanist-SemiBold',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Center(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x40000000),
                                offset: Offset(4, 4),
                                blurRadius: 4,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signin');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF369FFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Urbanist-Bold',
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPField(int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.18, // ~18% of screen width
      height: screenHeight * 0.07, // ~9% of screen height
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(4, 6),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 24, color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor:
              _focusNodes[index].hasFocus ? Colors.transparent : Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xFF53C1BC), width: 3),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus();
          }
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }
}
