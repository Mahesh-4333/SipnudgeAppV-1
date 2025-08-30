import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/constants/app_colors.dart';

class NavItemWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required Null Function() onTab,
  });

  @override
  State<NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<NavItemWidget> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final assetPath = 'assets/${widget.label.toLowerCase()}.png';
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.9),
      onTapUp: (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),
      onTap: widget.onTap,
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
                    widget.isActive
                        ? const LinearGradient(
                          colors: [Color(0xFFFAFAFA), Color(0xFF3E3E3E)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                        : null,
                color: widget.isActive ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(48.r),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 4),
                    color:
                        widget.isActive
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
                        widget.isActive
                            ? const LinearGradient(
                              colors: [Color(0xFFB182BA), Color(0xFF2D1B31)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                            : null,
                    color: widget.isActive ? null : Colors.transparent,
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
                            widget.icon,
                            size: screenWidth * 0.055,
                            color: Colors.white,
                          );
                        },
                      ),
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: AppColors.white,
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
  }
}
