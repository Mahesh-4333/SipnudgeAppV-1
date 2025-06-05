import 'package:flutter/material.dart';

class TooltipPage extends StatefulWidget {
  const TooltipPage({super.key});

  @override
  State<TooltipPage> createState() => _TooltipPageState();
}

class _TooltipPageState extends State<TooltipPage> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    
    // Calculate responsive sizes
    final outerCircleSize = screenWidth * 0.12;
    final innerCircleSize = outerCircleSize * 0.75;
    final fontSize = screenWidth * 0.025;
    
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Main circle with purple background
              Container(
                width: outerCircleSize,
                height: outerCircleSize * 1.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Image.asset(
                  'assets/purple_circle.png',
                  fit: BoxFit.contain,
                ),
              ),
              // Inner white circle with text
              Container(
                width: innerCircleSize,
                height: innerCircleSize,
                margin: EdgeInsets.all(outerCircleSize * 0.13),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    '70%',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                      fontFamily: 'urbanist-Bold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

