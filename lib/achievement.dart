import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/levelreached.dart';

class BadgeWithConcentricBackground extends StatefulWidget {
  const BadgeWithConcentricBackground({super.key});

  @override
  State<BadgeWithConcentricBackground> createState() =>
      _BadgeWithConcentricBackgroundState();
}

class _BadgeWithConcentricBackgroundState
    extends State<BadgeWithConcentricBackground> {
  int currentLevel = 1; // Change this dynamically based on your logic
  String title = 'Home';
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
          child: Column(
            children: [
              // Top section with back button and badge
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    // Back button at top left
                    Positioned(
                      top: 20.h,
                      left: 20.w,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    // ConcentricCirclesAnimation at top center
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, bottom: 30.h),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ConcentricCirclesAnimation(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.h),
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/achievmentimage.png',
                                    width: 330.w,
                                    height: 320.h,
                                    fit: BoxFit.contain,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 36.w),
                                    child: ShaderMask(
                                      shaderCallback:
                                          (bounds) => const LinearGradient(
                                            colors: [
                                              Color(0xFF8C41FD),
                                              Color(0xFF7800BD),
                                              Color(0xFFAE58E0),
                                              Color(0xFFA66CFD),
                                            ],
                                          ).createShader(
                                            Rect.fromLTWH(
                                              0,
                                              0,
                                              bounds.width,
                                              bounds.height,
                                            ),
                                          ),
                                      blendMode: BlendMode.srcIn,
                                      child: Transform.translate(
                                        offset: Offset(
                                          0,
                                          -5.h,
                                        ), // moves text 10 logical pixels up (adjust as needed)
                                        child: Text(
                                          '$currentLevel', // dynamically shows the current level
                                          style: TextStyle(
                                            fontSize: 74.sp,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'poppins-Bold',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Congratulatory text
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 338.h),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "You've Reached Level $currentLevel!",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'urbanist-bold',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.sp,
                                shadows: [
                                  Shadow(
                                    color: Color(0x20000000),
                                    offset: Offset(0, 2.r),
                                    blurRadius: 4.r,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              //padding: EdgeInsets.symmetric(horizontal: 40.w),
                              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                              child: Text(
                                "Congratulations! You've reached goal of 350 water intake. Keep up the incredible effort!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'urbanist-SemiBold',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFFFF).withOpacity(0.50),
                                  fontSize: 14.sp,
                                  letterSpacing: 1.sp,
                                  shadows: [
                                    Shadow(
                                      color: Color(0x20000000),
                                      offset: Offset(0, 2.r),
                                      blurRadius: 4.r,
                                    ),
                                  ],
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

              SizedBox(height: 10.h),

              // Achievement levels grid
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    // Grid content
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r),
                      ),
                      child: Container(
                        //padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        decoration: BoxDecoration(color: Color(0x12FFFFFF)),
                        child: GridView.builder(
                          padding: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                            top: 10.h,
                            bottom: 90.h,
                          ), // leave space for nav bar
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 0.h,
                                childAspectRatio: 0.94.r,
                              ),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            final level = index + 1;
                            final isUnlocked = level <= currentLevel;

                            return GestureDetector(
                              onTap: () {
                                if (isUnlocked) return;
                                setState(() {
                                  currentLevel = level;
                                });
                                if (level == currentLevel) {
                                  showLevelUpDialog(context, level, '15.4L');
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 0.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 190.w,
                                      height: 100.h,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 12.w),
                                        child: Center(
                                          child: Image.asset(
                                            isUnlocked
                                                ? 'assets/img$level.png'
                                                : 'assets/lockimg.png',
                                            fit: BoxFit.cover,
                                            color:
                                                isUnlocked
                                                    ? null
                                                    : const Color(0xff888593),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, -26.h),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Level $level',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'urbanist-bold',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            level == currentLevel
                                                ? 'Current level'
                                                : 'Weekly Intake: 15.4L',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'urbanist-regular',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Floating Bottom Navigation Bar
                    Positioned(
                      left: 6.w,
                      right: 6.w,
                      bottom: 6.h,
                      child: Container(
                        height: screenHeight * 0.09,
                        margin: EdgeInsets.only(
                          left: screenWidth * 0.05,
                          right: screenWidth * 0.05,
                          bottom: screenHeight * 0.01,
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
                            padding: EdgeInsets.only(
                              left: screenHeight * 0.007.w,
                              right: screenHeight * 0.006.w,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2B2536),
                              borderRadius: BorderRadius.circular(90.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildNavItem(
                                  Icons.home,
                                  'Home',
                                  title == 'Home',
                                  screenWidth,
                                  screenHeight,
                                ),
                                _buildNavItem(
                                  Icons.analytics_outlined,
                                  'Analysis',
                                  title == 'Analysis',
                                  screenWidth,
                                  screenHeight,
                                ),
                                _buildNavItem(
                                  Icons.lightbulb_outline,
                                  'Goals',
                                  title == 'Goals',
                                  screenWidth,
                                  screenHeight,
                                ),
                                _buildNavItem(
                                  Icons.settings,
                                  'Settings',
                                  title == 'Settings',
                                  screenWidth,
                                  screenHeight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /*Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                  child: Container(
                    //margin: EdgeInsets.only(left: 20.w),
                    //padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF).withOpacity(0.10),
                      //borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        //crossAxisSpacing: 5.w,
                        mainAxisSpacing: 0.h,
                        childAspectRatio: 0.87.r,
                      ),
                      itemCount: 10,
                      /*itemBuilder: (context, index) {
                        final level = index + 1;
                        final isUnlocked = level <= 7;*/
                      itemBuilder: (context, index) {
                        final level = index + 1;
                        final isUnlocked = level <= currentLevel;
                        return GestureDetector(
                          // onTap: () {
                          //   setState(() {
                          //     currentLevel = level; // ✅ update level on tap
                          //   });
                          // },
                          onTap: () {
                            if (isUnlocked) return;

                            setState(() {
                              currentLevel = level;
                            });

                            // Show dialog if this is the first time reaching this level
                            if (level == currentLevel) {
                              // Example logic — replace with your actual condition
                              showLevelUpDialog(context, level, '15.4L');
                            }
                          },

                          //child: Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 190.w,
                                  height: 120.h,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Center(
                                      child: Image.asset(
                                        isUnlocked
                                            ? 'assets/img$level.png'
                                            : 'assets/lockimg.png',
                                        // width: 120.w,
                                        // height: 137.h,
                                        fit: BoxFit.cover,
                                        color:
                                            isUnlocked
                                                ? null
                                                : Color(0xff888593),
                                      ),
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0, -26.h),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Level $level',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'urbanist-bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        level == currentLevel
                                            ? 'Current level'
                                            : 'Weekly Intake: 15.4L',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'urbanist-regular',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //),
                        );
                      },
                    ),
                  ),
                ),
              ),*/
              /*Container(
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
                    padding: EdgeInsets.only(
                      left: screenHeight * 0.007.w,
                      right: screenHeight * 0.006.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2536),
                      borderRadius: BorderRadius.circular(90.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(
                          Icons.home,
                          'Home',
                          title == 'Home',
                          screenWidth,
                          screenHeight,
                        ),
                        _buildNavItem(
                          Icons.analytics_outlined,
                          'Analysis',
                          title == 'Analysis',
                          screenWidth,
                          screenHeight,
                        ),
                        _buildNavItem(
                          Icons.lightbulb_outline,
                          'Goals',
                          title == 'Goals',
                          screenWidth,
                          screenHeight,
                        ),
                        _buildNavItem(
                          Icons.settings,
                          'Settings',
                          title == 'Settings',
                          screenWidth,
                          screenHeight,
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
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
          onTapDown: (_) => setState(() => scale = 0.9),
          onTapUp: (_) => setState(() => scale = 1.0),
          onTapCancel: () => setState(() => scale = 1.0),
          onTap: () {
            debugPrint('Tapped on: $label');
            _handleBottomNavigation(label);
          },
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    gradient:
                        isActive
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
                        color:
                            isActive
                                ? const Color(0x40000000)
                                : Colors.transparent,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      width: screenWidth * 0.19,
                      height: screenHeight * 0.055,
                      decoration: BoxDecoration(
                        gradient:
                            isActive
                                ? const LinearGradient(
                                  colors: [
                                    Color(0xFFB182BA),
                                    Color(0xFF2D1B31),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                                : null,
                        color: isActive ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(46),
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
                              debugPrint(
                                'Error loading image: $assetPath - $error',
                              );
                              return Icon(
                                icon,
                                size: screenWidth * 0.055,
                                color: Colors.white,
                              );
                            },
                          ),
                          Text(
                            label,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.03,
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label screen coming soon!')));
    }
  }
}

class ConcentricCirclesAnimation extends StatefulWidget {
  final Widget child;

  const ConcentricCirclesAnimation({super.key, required this.child});

  @override
  State<ConcentricCirclesAnimation> createState() =>
      _ConcentricCirclesAnimationState();
}

class _ConcentricCirclesAnimationState extends State<ConcentricCirclesAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConcentricCirclePainter(animation: _animation),
      child: Center(child: widget.child),
    );
  }
}

class ConcentricCirclePainter extends CustomPainter {
  final Animation<double> animation;

  ConcentricCirclePainter({required this.animation})
    : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    final Offset center = Offset(size.width / 2.15, size.height / 2);
    final double maxRadius = min(size.width, size.height) / 1.8;
    const int circleCount = 12;

    for (int i = 0; i < circleCount; i++) {
      final double offset = (i + animation.value) % circleCount;
      final radius = (offset / circleCount) * maxRadius;
      final color =
          Color.lerp(
            Color(0xFFF4D44E),
            Color(0xFF746080),
            offset / circleCount,
          )!;
      paint.color = color.withOpacity(1 - (offset / circleCount));
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
