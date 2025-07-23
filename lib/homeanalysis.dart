//import 'dart:nativewrappers/_internal/vm/lib/isolate_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeAnalysisPage extends StatefulWidget {
  const HomeAnalysisPage({super.key});

  @override
  State<HomeAnalysisPage> createState() => _HomeAnalysisPageState();
}

class _HomeAnalysisPageState extends State<HomeAnalysisPage> {
  bool isChartActive = true;

  String title = 'Analysis';
  String selectedPeriod = 'Weekly';
  // Current date for the date range
  DateTime _currentStartDate = DateTime.now().subtract(const Duration(days: 7));
  bool IsSelected = false;
  int? tappedIndex; // null means no tooltip shown
  int _getValueByIndex(int index) {
    const values = [100, 70, 90, 100, 85, 95, 75];
    return (index >= 0 && index < values.length) ? values[index] : 0;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB586BE), Color(0xFF131313)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),

                  // Period selector
                  Container(
                    width: 379.w,
                    height: 104.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF907396),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: Color(0x66FFFFFF), width: 1),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 8.h,
                          ),
                          child: Container(
                            height: 40.h,
                            //padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Row(
                              children:
                                  ['Weekly', 'Monthly', 'Yearly'].map((period) {
                                    final isSelected = selectedPeriod == period;
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap:
                                            () => setState(
                                              () => selectedPeriod = period,
                                            ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                isSelected
                                                    ? const Color(0xFFA964E0)
                                                    : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              360.r,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              period,
                                              style: TextStyle(
                                                color:
                                                    isSelected
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontSize: 16.sp,
                                                fontFamily: 'Urbanist-Bold',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_left,
                                  size: 30.sp,
                                  color: Color(0xFF212121),
                                ),
                                onPressed: () => _updateDateRange(false),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                              Text(
                                _getFormattedDateRange(),
                                style: TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 16.sp,
                                  fontFamily: 'Urbanist-SemiBold',
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.chevron_right,
                                  size: 30.sp,
                                  color: Color(0xFF9E9E9E),
                                ),
                                onPressed: () => _updateDateRange(true),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Drink Completion Section
                  _buildDrinkCompletionSection(screenWidth, screenHeight),

                  SizedBox(height: screenHeight * 0.02),

                  // Hydration Source Section
                  _buildHydrationSourceSection(screenWidth, screenHeight),

                  const Spacer(),

                  // Bottom Navigation
                  Container(
                    height: screenHeight * 0.09,
                    //width: screenWidth * 0.09,
                    margin: EdgeInsets.only(
                      left: screenWidth * 0.001,
                      right: screenWidth * 0.001,
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
                          right: screenHeight * 0.007.w,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*Widget _buildPeriodButton(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedPeriod = label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB586BE) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontFamily: 'Urbanist-Medium',
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }*/

  BarChartGroupData _buildBarGroup(int x, double y, double screenWidth) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: screenWidth * 0.08,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
          color: tappedIndex == x ? Color(0xFF6C00C3) : Color(0xFF834fad),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            color: Color(0x10FFFFFF),
            //color: Colors.white.withOpacity(0.1),
          ),
        ),
      ],
      showingTooltipIndicators: tappedIndex == x ? [0] : [],
    );
  }

  // for water and food prcentage in hydration source
  Widget _buildLegendItem(String label, Color color, double screenWidth) {
    return Row(
      children: [
        Container(
          width: screenWidth * 0.04,
          height: screenWidth * 0.04,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.035,
            fontFamily: 'Urbanist-Medium',
          ),
        ),
      ],
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
  /*Widget _buildNavItem(IconData icon, String label, bool isActive) {
    final assetPath = 'assets/${label.toLowerCase()}.png';
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
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
                      isActive ? const Color(0x40000000) : Colors.transparent,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(1.w),
              child: Container(
                width: screenWidth * 0.19,
                height: screenHeight * 0.055,
                decoration: BoxDecoration(
                  gradient:
                      isActive
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
                      width: 24,
                      height: 24,
                      color: Colors.white,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Error loading image: $assetPath - $error');
                        return Icon(icon, size: 22, color: Colors.white);
                      },
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: 12.sp,
                        fontFamily: 'Lexend-Regular',
                        fontWeight:
                            isActive ? FontWeight.w300 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }*/

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
        //Navigator.pushNamed(context, '/preferences');
        Navigator.pushNamed(context, '/achievement');
        break;
      default:
        debugPrint('No route defined for $label');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label screen coming soon!')));
    }
  }

  // Get formatted date range string
  String _getFormattedDateRange() {
    final endDate = _currentStartDate.add(const Duration(days: 6));

    // Format: "Dec 16 - Dec 22, 2024"
    final startMonth = _getShortMonth(_currentStartDate.month);
    final endMonth = _getShortMonth(endDate.month);

    return '$startMonth ${_currentStartDate.day} - $endMonth ${endDate.day}, ${endDate.year}';
  }

  // Get short month name
  String _getShortMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  // Update date range based on navigation
  void _updateDateRange(bool forward) {
    setState(() {
      if (forward) {
        _currentStartDate = _currentStartDate.add(const Duration(days: 7));
      } else {
        _currentStartDate = _currentStartDate.subtract(const Duration(days: 7));
      }
    });
  }

  Widget _buildDrinkCompletionSection(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Drink Completion',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: screenWidth * 0.045,
                  fontFamily: 'Urbanist-Bold',
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(screenWidth * 0.010),
                ),
                child: Row(
                  children: [
                    _chartIcon(
                      screenWidth: screenWidth,
                      icon: Icons.bar_chart_rounded,
                      isActive: isChartActive,
                      onTap: () {
                        setState(() => isChartActive = true);
                      },
                    ),
                    const SizedBox(width: 8),
                    _chartIcon(
                      screenWidth: screenWidth,
                      icon: Icons.insert_chart_outlined_rounded,
                      isActive: !isChartActive,
                      onTap: () {
                        setState(() => isChartActive = false);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          // Circle indicator
          Stack(alignment: Alignment.center, children: [            
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          // Bar chart
          SizedBox(
            height: screenHeight * 0.25, // Increased to make room for tooltip
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                /// Chart UI
                BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 100,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: EdgeInsets.zero,
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          // Return transparent item to suppress default tooltip
                          return BarTooltipItem(
                            '',
                            TextStyle(color: Colors.transparent),
                          );
                        },
                      ),
                      touchCallback: (
                        FlTouchEvent event,
                        BarTouchResponse? response,
                      ) {
                        if (event.isInterestedForInteractions &&
                            response != null &&
                            response.spot != null) {
                          setState(() {
                            tappedIndex = response.spot!.touchedBarGroupIndex;
                          });
                        } else {
                          setState(() {
                            tappedIndex = null;
                          });
                        }
                      },
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            const days = [
                              '16',
                              '17',
                              '18',
                              '19',
                              '20',
                              '21',
                              '22',
                            ];
                            return Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child:
                                  (value >= 0 && value < days.length)
                                      ? Text(
                                        days[value.toInt()],
                                        style: TextStyle(
                                          color: Color(0xFFFFF8F8),
                                          fontFamily: 'Urbanist-Medium',
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.030,
                                        ),
                                      )
                                      : const Text(''),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          getTitlesWidget: (value, meta) {
                            return (value % 20 == 0)
                                ? Text(
                                  '${value.toInt()}%',
                                  style: TextStyle(
                                    color: Color(0xFFFFF8F8),
                                    fontFamily: 'Urbanist-Medium',
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.030,
                                  ),
                                )
                                : const Text('');
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    barGroups: [
                      _buildBarGroup(0, 100, screenWidth),
                      _buildBarGroup(1, 70, screenWidth),
                      _buildBarGroup(2, 90, screenWidth),
                      _buildBarGroup(3, 100, screenWidth),
                      _buildBarGroup(4, 85, screenWidth),
                      _buildBarGroup(5, 95, screenWidth),
                      _buildBarGroup(6, 75, screenWidth),
                    ],
                  ),
                ),

                /// Custom Tooltip Overlay
                if (tappedIndex != null)
                  Positioned(
                    top: screenHeight * 0.01, // Slightly above the bars
                    left:
                        screenWidth * (0.12 + tappedIndex! * 0.13) -
                        (screenWidth * 0.065), // Center tooltip above bar
                    child: CustomTooltip(
                      percentage: _getValueByIndex(tappedIndex!),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.01),
        ],
      ),
    );
  }

  /* Widget _chartIcon(
    double screenWidth,
    IconData icon,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.13,
        height: screenWidth * 0.13 * 0.6,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF8E00FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(screenWidth * 0.010),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            size: screenWidth * 0.06,
            color: isActive ? Colors.white : const Color(0xFFBDBDBD),
          ),
        ),
      ),
    );
  }*/

  Widget _chartIcon({
    required double screenWidth,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.11,
        height: screenWidth * 0.13 * 0.6,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF7C00FF) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(screenWidth * 0.010),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Icon(
                  icon,
                  color: isActive ? Colors.white : const Color(0xFF9D9D9D),
                  size: screenWidth * 0.06,
                ),
              ),
              if (!isActive)
                Positioned(
                  right: screenWidth * 0.025,
                  top: screenWidth * 0.012,
                  child: Container(
                    width: screenWidth * 0.018,
                    height: screenWidth * 0.018,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      //color: Color(0xFF7C00FF),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHydrationSourceSection(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hydration Source',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: screenWidth * 0.045,
              fontFamily: 'Urbanist-Bold',
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              Container(
                width: screenWidth * 0.25,
                height: screenWidth * 0.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF2196F3),
                    width: screenWidth * 0.015,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '100%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontFamily: 'Urbanist-Bold',
                        ),
                      ),
                      Text(
                        'Water Intake',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.025,
                          fontFamily: 'Urbanist-Medium',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem(
                    'Water (80%)',
                    const Color(0xFF2196F3),
                    screenWidth,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildLegendItem(
                    'Food (20%)',
                    const Color(0xFFE91E63),
                    screenWidth,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTooltip extends StatelessWidget {
  final int percentage;
  const CustomTooltip({required this.percentage, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final outerSize = screenWidth * 0.13; // Size of purple image
    final innerSize = outerSize * 0.75; // White circle should be ~75%

    return SizedBox(
      width: outerSize,
      height: outerSize * 1.15, // vertical extension to fit tail
      child: Stack(
        //alignment: Alignment.center,
        children: [
          /*Image.asset(
            'assets/purple_circle.png',
            width: outerSize,
            height: outerSize * 1.15,
            fit: BoxFit.contain,
          ),
          Container(
            width: innerSize,
            height: innerSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'urbanist-Bold',
                ),
              ),
            ),
          ),*/
          Image.asset(
            'assets/Union1.png',
            width: outerSize,
            height: outerSize * 1.15,
            fit: BoxFit.contain,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 26.h, left: 2.w),
            alignment: Alignment.bottomCenter,
            child: Text(
              '$percentage%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                //fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w700,
                color: Color(0xFF424242),
                fontFamily: 'urbanist-Bold',
              ),
            ),
          ),
          //),
        ],
      ),
    );
  }
}
