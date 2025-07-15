import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class CompanyMottoPage extends StatefulWidget {
  const CompanyMottoPage({super.key});

  @override
  State<CompanyMottoPage> createState() => _CompanyMottoPage();
}

class _CompanyMottoPage extends State<CompanyMottoPage> {
  @override
  void initState() {
    super.initState();

    // Navigate to home after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/signin_signupsage');
    });
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
          alignment: Alignment.center,
          children: [
            // Centered image with blur
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Image.asset(
                      'assets/back new app sipnudge.png',
                      width: 900,
                      height: 900,
                      fit: BoxFit.cover,
                      color: Color(0x40000000),
                    ),
                  ),
                  Image.asset(
                    'assets/back new app sipnudge.png',
                    width: 900,
                    height: 900,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),

            // "AI Meets" Text
            Positioned(
              bottom: 150,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 33,
                      fontFamily: 'MuseoModerno-Bold',
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 6,
                          color: Color(0x40000000),
                        )
                      ],
                    ),
                    children: [
                      const TextSpan(
                        text: 'AI ',
                        style: TextStyle(
                          color: Color(0xFFE6A1F3),
                          shadows: [
                            Shadow(
                              offset: Offset(3, 3),
                              blurRadius: 7,
                              color: Color(0x40000000),
                            )
                          ],
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(0xFFCBA7E0),
                              Color(0xFF89B4DD),
                              Color(0xFFA6F7FF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                          blendMode: BlendMode.srcIn,
                          child: const Text(
                            'Meets',
                            style: TextStyle(
                              fontSize: 33,
                              fontFamily: 'MuseoModerno-Bold',
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 7,
                                  color: Color(0x40000000),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // "Hydration" Text
            Positioned(
              bottom: 110,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 33,
                      fontFamily: 'MuseoModerno-Bold',
                    ),
                    children: [
                      TextSpan(
                        text: 'Hydration',
                        style: TextStyle(
                          color: Color(0xFF89EFF5),
                          shadows: [
                            Shadow(
                              offset: Offset(3, 3),
                              blurRadius: 7,
                              color: Color(0x40000000),
                            )
                          ],
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
}
