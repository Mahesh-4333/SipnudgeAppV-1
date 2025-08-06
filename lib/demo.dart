// import 'package:flutter/material.dart';

// class TooltipPage extends StatefulWidget {
//   const TooltipPage({super.key});

//   @override
//   State<TooltipPage> createState() => _TooltipPageState();
// }

// class _TooltipPageState extends State<TooltipPage> {
//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions
//     final size = MediaQuery.of(context).size;
//     final screenWidth = size.width;

//     // Calculate responsive sizes
//     final outerCircleSize = screenWidth * 0.12;
//     final innerCircleSize = outerCircleSize * 0.75;
//     final fontSize = screenWidth * 0.025;

//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               // Main circle with purple background
//               Container(
//                 width: outerCircleSize,
//                 height: outerCircleSize * 1.15,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.transparent,
//                 ),
//                 child: Image.asset(
//                   'assets/purple_circle.png',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               // Inner white circle with text
//               Container(
//                 width: innerCircleSize,
//                 height: innerCircleSize,
//                 margin: EdgeInsets.all(outerCircleSize * 0.13),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//                 child: Center(
//                   child: Text(
//                     '70%',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: fontSize,
//                       fontFamily: 'urbanist-Bold',
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrinkCompletionChart extends StatelessWidget {
  const DrinkCompletionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF7F3EFF), Color(0xFF6C4B9E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 100,
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  const days = ['16', '17', '18', '19', '20', '21', '22'];
                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        days[value.toInt()],
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                reservedSize: 40,
                getTitlesWidget:
                    (value, meta) => Text(
                      '${value.toInt()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: 'Urbanist',
                      ),
                    ),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.white,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.7),
                    Colors.blue.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 6,
                    color: Colors.white,
                    strokeColor: Colors.deepPurple,
                    strokeWidth: 3,
                  );
                },
              ),
              spots: const [
                FlSpot(0, 90),
                FlSpot(1, 70),
                FlSpot(2, 95),
                FlSpot(3, 65),
                FlSpot(4, 80),
                FlSpot(5, 95),
                FlSpot(6, 60),
              ],
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipRoundedRadius: 10,
              tooltipBgColor: Colors.white,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final value = spot.y;
                  return LineTooltipItem(
                    '${(value * 0.03).toStringAsFixed(1)}L', // approximate L value
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  );
                }).toList();
              },
            ),
            handleBuiltInTouches: true,
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((i) {
                return TouchedSpotIndicatorData(
                  FlLine(color: Colors.transparent),
                  FlDotData(show: true),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
