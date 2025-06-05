import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wave/config.dart' show CustomConfig;
import 'package:wave/wave.dart' show WaveWidget;

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String title = 'Home'; // Add this line to track active tab

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: screenHeight),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB586BE), Color(0xFF131313)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  /// Top Greeting Section
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.08,
                      right: screenWidth * 0.05,
                      top: screenHeight * 0.09,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Morning",
                              style: TextStyle(
                                fontSize: screenWidth * 0.040,
                                fontFamily: 'MuseoModerno-Medium',
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.006),
                            Text(
                              "Newton Singh",
                              style: TextStyle(
                                fontSize: screenWidth * 0.058,
                                fontFamily: 'MuseoModerno-Bold',
                                color: const Color(0xFF141A1E),
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        /// Progress Indicator with Red Dot
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenWidth * 0.03, 
                            right: screenWidth * 0.08
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -screenWidth * 0.04,
                                child: BreathingRedDot(
                                  size: screenWidth * 0.025,
                                  borderColor: Color(0xFF9677E9),
                                  borderWidth: 1.0.w,
                                ),
                              ),
                              CustomCircularProgress(progress: 0.8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.010),
                  /// Weather and Reminder
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.06,
                      right: screenWidth * 0.04,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            /*Image.asset(
                              'assets/sun.png',
                              width: screenWidth * 0.090,
                              height: screenWidth * 0.090,
                            
                            ),*/
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [Color(0xFFFFE475), Color(0xFFFFBF29)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.dstIn,
                              child: Image.asset(
                                'assets/sun.png',
                                width: screenWidth * 0.090,
                                height: screenWidth * 0.090,
                              ),
                            ),
                            Text(
                              "26°C",
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontFamily: 'Poppins-SemiBold',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.020),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "It's a ",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.032,
                                          fontFamily: 'MuseoModerno-Regular',
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Sunny Day",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.032,
                                          fontFamily: 'MuseoModerno-SemiBold',
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " today!",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.032,
                                          fontFamily: 'MuseoModerno-Regular',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Remember to stay hydrated throughout the day",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.032,
                                    fontFamily: 'museoModerno-Medium',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                    Container(
                      height: screenHeight * 0.08,
                      margin: EdgeInsets.only(
                        left: screenWidth * 0.08,
                        right: screenWidth * 0.08,
                        //bottom: screenHeight * 0.02,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90.r),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3F3F3F), Color(0xFFFFFFFF)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 2),
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.r),
                            color: Color(0xFF8E76AE),
                          ),
                        
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.013,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/water drop.png',
                                width: screenWidth * 0.065,
                                height: screenWidth * 0.07,
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Water",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      fontFamily: 'Urbanist-Medium',
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005), // 4px spacing
                                  Text(
                                    "500ml",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontFamily: 'Urbanist-Bold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                    height: screenHeight * 0.032,
                                    width: screenWidth * 0.28,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(90.r),
                                      color: Color(0xFFBD95D1),
                                      border: Border.all(color: Color(0xFFFFFCFC), width: 1.w),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          //spreadRadius: 1,
                                        ),
                                      ]
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: screenWidth * 0.00,
                                        right: screenHeight * 0.00,
                                        top: screenHeight * 0.003,
                                        //bottom: screenHeight * 0.02,
                                    ),
                                  child: Text(
                                    "Breakfast Time", 
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      fontFamily: 'Urbanist-Bold',
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                  ),
                                )
                              ),
                             //),
                             SizedBox(width: screenWidth * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Completed",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      fontFamily: 'Urbanist-Medium',
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005), // 4px spacing
                                  Text(
                                    "100%",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontFamily: 'Urbanist-Bold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      )
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.009),

                  /// Bottle + Wave + Circular Text Progress
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/home page bottle image1.png',
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.4,
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: screenHeight * 0.18,
                          child: Container(
                            width: screenWidth * 0.13,
                            height: screenHeight * 0.11,
                            margin: EdgeInsets.only(right: 2.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.r),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(4, 4),
                                  color: Color(0xFF000000).withOpacity(0.25),
                                  blurRadius: 4,
                                  //spreadRadius: 1,
                                ),
                              ]
                            ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: WaveWidget(
                                      config: CustomConfig(
                                        colors: [
                                          const Color(0xFFB3F0F8).withOpacity(0.6),
                                          const Color(0xFF70D6ED).withOpacity(0.5),
                                          const Color(0xFF1C7FA7).withOpacity(0.4),
                                          const Color(0xFF005D84).withOpacity(0.3),
                                        ],
                                        durations: [10000, 10500, 11000, 11500], // Faster wave animation
                                        heightPercentages: [0.10, 0.11, 0.12, 0.13],
                                      ),
                                      waveAmplitude: 1,
                                      backgroundColor: Colors.transparent,
                                      size: const Size(double.infinity, double.infinity),
                                      waveFrequency: 0.8, // Increased frequency for faster waves
                                      isLoop: true,
                                    ),
                                  ),
                                  Text(
                                    "90%",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      fontFamily: 'MuseoModerno-SemiBold',
                                      color: Color(0xFF12121A),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: screenHeight * 0.075,
                            child: CircularLoadingAnimation(
                              size: screenWidth * 0.14,
                              strokeWidth: screenWidth * 0.015,
                              centerText: "\t\t2.5L\n/0.15L",
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: screenHeight * 0.001),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center, 
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "You got 50% of today’s goal, keep focus\non your health!",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'MuseoModerno-Medium',
                                  color: Color(0xFFFDFEFF),
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 8,
                                      color: Color(0x40000000),
                                    )
                                  ]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.06),
                  
                  /// Bottom Navigation
                  Container(
                    height: screenHeight * 0.09,
                    //width: screenWidth * 0.09,
                    margin: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      bottom: screenHeight * 0.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90.r),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3F3F3F), Color(0xFFFFFFFF)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(1.w),
                      child: Container(
                        padding: EdgeInsets.only(left: screenHeight * 0.007.w, right: screenHeight * 0.006.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2536),
                          borderRadius: BorderRadius.circular(90.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNavItem(Icons.home, 'Home', title == 'Home', screenWidth, screenHeight),
                            _buildNavItem(Icons.analytics_outlined, 'Analysis', title == 'Analysis', screenWidth, screenHeight),
                            _buildNavItem(Icons.lightbulb_outline, 'Goals', title == 'Goals', screenWidth, screenHeight),
                            _buildNavItem(Icons.settings, 'Settings', title == 'Settings', screenWidth, screenHeight),
                          ],
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
    );
  }
  Widget _buildNavItem(
  IconData icon,
  String label,
  bool isActive,
  double screenWidth,
  double screenHeight,
) {
  final assetPath = 'assets/${label.toLowerCase()}.png';
  double scale = 1.0;

  return StatefulBuilder(
    builder: (context, setState) {
      return GestureDetector(
        onTapDown: (_) => setState(() => scale = 0.70),
        onTapUp: (_) => setState(() => scale = 0.90),
        onTapCancel: () => setState(() => scale = 0.90),
        onTap: () {
          debugPrint('Tapped on: $label');
          _handleBottomNavigation(label);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.2,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                gradient: isActive
                    ? const LinearGradient(
                        colors: [Color(0xFFFAFAFA), Color(0xFF3E3E3E)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                color: isActive ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(48.r),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 4),
                    color: isActive ? const Color(0x40000000) : Colors.transparent,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 100),
                child: Padding(
                  padding: EdgeInsets.all(1.r),
                  child: Container(
                    width: screenWidth * 0.19,
                    height: screenHeight * 0.055,
                    decoration: BoxDecoration(
                      gradient: isActive
                          ? const LinearGradient(
                              colors: [Color(0xFFB182BA), Color(0xFF2D1B31)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : null,
                      color: isActive ? null : Colors.transparent,
                      borderRadius: BorderRadius.circular(46.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          assetPath,
                          width: screenWidth * 0.06,
                          height: screenWidth * 0.06,
                          color: Colors.white,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('Error loading image: $assetPath - $error');
                            return Icon(icon, size: screenWidth * 0.055, color: Colors.white);
                          },
                        ),
                        Text(
                          label,
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

  void _handleBottomNavigation(String label) {   
    setState(() {
      title = label; // Update active tab
    });
    
    switch (label) {
      case 'Home':
        Navigator.pushNamed(context, '/homepage');
        break;
      case 'Analysis':
        Navigator.pushNamed(context, '/analysis');
        break;
      case 'Goals':
        Navigator.pushNamed(context, '/dailygoalpage');
        break;
      case 'Settings':
        Navigator.pushNamed(context, '/preferences');
        break;
      default:
        debugPrint('No route defined for $label');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label screen coming soon!')),
        );
    }
  }
}

// Circular Loading Animation Widget
class CircularLoadingAnimation extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final String centerText;

  const CircularLoadingAnimation({
    super.key,
    this.size = 150.0,
    this.strokeWidth = 10.0,
    this.centerText = "/0.15L",
  });

  @override
  State<CircularLoadingAnimation> createState() => _CircularLoadingAnimationState();
}

class _CircularLoadingAnimationState extends State<CircularLoadingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF936FA7),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 5,
            color: Color(0x40000000),
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size(widget.size - 4.w, widget.size - 4.w),
                painter: _CircularProgressPainter(
                  progress: 0.85,
                  strokeWidth: widget.strokeWidth,
                  animation: _controller.value,
                ),
              );
            },
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "2.5L\n",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: widget.size * 0.22,
                    fontFamily: 'MuseoModerno-Bold',
                  ),
                ),
                TextSpan(
                  text: "/0.15L",
                  style: TextStyle(
                    color: const Color(0xFF9AE0DF),
                    fontFamily: 'MuseoModerno-Medium',
                    fontSize: widget.size * 0.16,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final double animation;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final shadowPaint = Paint()
    ..color = const Color(0x40000000) // Shadow color
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawCircle(center.translate(3, 4), radius, shadowPaint); // Offset shadow

    final backgroundPaint = Paint()
      ..color = Color(0x1CFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      colors: const [Color(0xFFFFFFFF), Color(0xFF48CAFF)],
      stops: const [0.0, 1.0],
      startAngle: 0,
      endAngle: 2 * pi,
      transform: GradientRotation(-pi / 1.8),
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class CustomCircularProgress extends StatelessWidget {
  final double progress;

  const CustomCircularProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 60.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            //padding: EdgeInsets.only(right: 5.w),
            decoration: BoxDecoration(
              color: const Color(0xFF896A98),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x10896A98),
                width: 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 46.w,
            height: 46.w,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 5.8.w,
              backgroundColor: Color(0xFFDDECDC),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF43E73E)),
              strokeCap: StrokeCap.round,
            
            ),
          ),
          Text(
            "${(progress * 100).toInt()}%",
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: 'MuseoModerno-SemiBold',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class BreathingRedDot extends StatefulWidget {
  final double size;
  final Color borderColor;
  final double borderWidth;

  const BreathingRedDot({
    required this.size,
    required this.borderColor,
    required this.borderWidth,
    Key? key,
  }) : super(key: key);

  @override
  State<BreathingRedDot> createState() => _BreathingRedDotState();
}

class _BreathingRedDotState extends State<BreathingRedDot> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _opacityAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: Color(0xFFFF0000),
                shape: BoxShape.circle,
                border: Border.all(color: widget.borderColor, width: widget.borderWidth),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
