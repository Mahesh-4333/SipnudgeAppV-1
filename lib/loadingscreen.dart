import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double percentage = 0.0;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // Animate percentage gradually up to 0.90
    timer = Timer.periodic(Duration(milliseconds: 35), (t) {
      setState(() {
        percentage += 0.01;
        if (percentage >= 0.90) {
          percentage = 0.96;
          timer.cancel();
          Timer(Duration(milliseconds: 1200), () {
            Navigator.pushNamed(context, '/dailygoalpage');
          });
          //Navigator.pushNamed(context, '/dailygoalpage');
        }
      });
    });

    // Navigate to home after 2 seconds
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Description
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.06,
                right: screenWidth * 0.06,
                top: screenHeight * 0.13,
              ),
              child: Text(
                "Analyzing your data to create a personalized hydration plan...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'MuseoModerno-Bold',
                  fontSize: screenWidth * 0.053,
                  color: Color(0xFFFFFFFF),
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Color(0x40000000),
                    ),
                  ],
                ),
              ),
            ),

            // Please Wait
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.015),
              child: Text(
                'Please wait...',
                style: TextStyle(
                  fontSize: screenWidth * 0.040,
                  fontFamily: 'Urbanist-Regular',
                  color: Color(0xFF86DCFF),
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Color(0x40000000),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.14),

            // Percentage Ring with Percentage Text
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: PercentageRingPainter(percentage: percentage),
                    size: Size(screenWidth * 0.6, screenWidth * 0.6),
                  ),
                  Text(
                    "${(percentage * 100).round()}%",
                    style: TextStyle(
                      fontSize: screenWidth * 0.11,
                      fontFamily: 'MuseoModerno-Bold',
                      color: Color(0xFFF4F4F4),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.14),

            // Bottom RichText Message
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'MuseoModerno-Regular',
                      fontSize: screenWidth * 0.041,
                      color: Color(0xFFFFFFFF),
                      shadows: const [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color(0x40000000),
                        ),
                      ],
                    ),
                    children: const [
                      TextSpan(text: "Almost there! "),
                      TextSpan(text: "Your personalized hydration\n"),
                      TextSpan(text: "plan is coming right up."),
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

class PercentageRingPainter extends CustomPainter {
  final double percentage;
  final int segmentCount = 100;
  final double strokeWidth = 20;
  final double spacing = 2;

  final Color startColor = Color(0xFFD918FF); // Intense Purple
  final Color endColor = Color(0x00000000); // Semi-transparent Black
  final Color backgroundColor = Color(0x05000000); // Dim gray for inactive

  PercentageRingPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2 - strokeWidth;
    final double anglePerSegment = (2 * math.pi) / segmentCount;
    final int activeSegments = (segmentCount * percentage).round();

    // 6 o'clock corresponds to 90 degrees => π / 2 radians
    final double startOffsetAngle = math.pi / 2;

    for (int i = 0; i < segmentCount; i++) {
      final double t = i / (segmentCount - 1);
      paint.color =
          i < activeSegments
              ? Color.lerp(startColor, endColor, t)!
              : backgroundColor;

      final double startAngle =
          startOffsetAngle + i * anglePerSegment + spacing * 0.01;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        anglePerSegment - spacing * 0.01,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
