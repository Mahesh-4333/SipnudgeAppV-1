import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BadgeWithConcentricBackground extends StatefulWidget {
  const BadgeWithConcentricBackground({super.key});

  @override
  State<BadgeWithConcentricBackground> createState() => _BadgeWithConcentricBackgroundState();
}

class _BadgeWithConcentricBackgroundState extends State<BadgeWithConcentricBackground> {
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
                              child: Image.asset(
                                'assets/achievment.png',
                                width: 330.w,
                                height: 320.h,
                                fit: BoxFit.contain,
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
                                "You've Reached Level 7!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
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
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14.sp,
                                ),
                              ),
                            )
                          ]
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
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.only(left:25.w, right: 20.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 5.h,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final level = index + 1;
                      final isUnlocked = level <= 7;
                      
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 122.w,
                            height: 137.h,
                            child: Center(
                              child: isUnlocked
                                  ? Image.asset(
                                      'assets/l$level.png',
                                      width: 122.w,
                                      height: 137.h,
                                      fit: BoxFit.contain,
                                    )
                                  : Image.asset(
                                      'assets/LL$level.png',
                                      width: 122.w,
                                      height: 137.w,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                          //SizedBox(height: 3.h),
                          /*Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Text(
                              'Level $level',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'urbanist-bold',
                                fontWeight: FontWeight.w700,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),*/
                          //SizedBox(height: 2.h),
                          /*Text(
                            isUnlocked ? 'Weekly Water: 3L' : 'Weekly Water: --',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontFamily: 'urbanist-medium',
                              fontWeight: FontWeight.w400,
                              fontSize: 9.sp,
                            ),
                          ),*/
                        ],
                      );
                    },
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

class ConcentricCirclesAnimation extends StatefulWidget {
  final Widget child;

  const ConcentricCirclesAnimation({super.key, required this.child});

  @override
  State<ConcentricCirclesAnimation> createState() => _ConcentricCirclesAnimationState();
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

  ConcentricCirclePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Offset center = Offset(size.width / 2.15, size.height / 2);
    final double maxRadius = min(size.width, size.height) / 1.8;
    const int circleCount = 12;

    for (int i = 0; i < circleCount; i++) {
      final double offset = (i + animation.value) % circleCount;
      final radius = (offset / circleCount) * maxRadius;
      final color = Color.lerp(Color(0xFFF4D44E), Color(0xFF746080), offset / circleCount)!;
      paint.color = color.withOpacity(1 - (offset / circleCount));
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
