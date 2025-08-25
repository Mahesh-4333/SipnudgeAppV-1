import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/cubit/reminder time&mode/water_intake_timeline_cubit.dart';
import 'package:flutterapp1/widgets/nav_bar_items.dart';

class WaterIntakeTimeline extends StatefulWidget {
  const WaterIntakeTimeline({super.key});

  @override
  State<WaterIntakeTimeline> createState() => _WaterIntakeTimelineState();
}

class _WaterIntakeTimelineState extends State<WaterIntakeTimeline> {
  String title = "Home";
  bool isSelected = false;

  Future<void> _selectDate(BuildContext context, HydrationState state) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: state.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null && selected != state.selectedDate) {
      context.read<HydrationCubit>().updateDate(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<HydrationCubit, HydrationState>(
      builder: (context, state) {
        return Scaffold(
          //backgroundColor: const Color(0xFF8C6FB5),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB586BE), Color(0xFF131313)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(30.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        right: 20.w,
                        top: 10.h,
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 30.sp,
                            color: Color(0xFF212121),
                          ),
                          SizedBox(width: 40.w),
                          Text(
                            'Water Intake Timeline',
                            style: TextStyle(
                              fontFamily: "Urbanist-Bold",
                              fontSize: 24.sp,
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, right: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProgressCircle(
                            drank: state.totalDrank,
                            goal: state.goal,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Today, 7 Mar",
                                style: TextStyle(
                                  fontFamily: "Urbanist-Bold",
                                  fontSize: 20.sp,
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextButton(
                                onPressed: () => _selectDate(context, state),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                // style: TextButton.styleFrom(
                                //   padding:
                                //       EdgeInsets
                                //           .zero, // Removes default padding
                                //   tapTargetSize:
                                //       MaterialTapTargetSize.shrinkWrap,
                                // ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Change date",
                                      style: TextStyle(
                                        fontFamily: "Urbanist-Medium",
                                        fontSize: 14.sp,
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Image.asset(
                                      "assets/downarrow.png",
                                      width: 10.w,
                                      height: 10.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 55.h, // Adjust as needed
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 11.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x10FFFFFF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 14.sp,
                                      fontFamily: 'Urbanist-Medium',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.4.sp,
                                    ),
                                  ),
                                  Text(
                                    "Water",
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 14.sp,
                                      fontFamily: 'Urbanist-Medium',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.4.sp,
                                    ),
                                  ),
                                  Text(
                                    "Status",
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 14.sp,
                                      fontFamily: 'Urbanist-Medium',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.4.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Divider(color: Colors.white24),

                    // Timeline Entries
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x20FFFFFF),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r),
                          ),
                        ),
                        child: ListView.separated(
                          itemCount: state.entries.length,
                          separatorBuilder:
                              (_, __) => Divider(color: Colors.white24),
                          itemBuilder: (context, index) {
                            final item = state.entries[index];
                            return InkWell(
                              onTap:
                                  () => context
                                      .read<HydrationCubit>()
                                      .toggleStatus(index),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left: Time label + time range
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.label,
                                            style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 14.sp,
                                              fontFamily: 'Urbanist-Medium',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.40.sp,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Row(
                                            children: [
                                              Text(
                                                item.timeRange,
                                                style: TextStyle(
                                                  color: Color(0x60FFFFFF),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Urbanist-Medium',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.4.sp,
                                                ),
                                              ),
                                              SizedBox(width: 4.w),
                                              GestureDetector(
                                                onTap: () {
                                                  _showTimeEditBottomSheet(
                                                    context,
                                                    index,
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 15.sp,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Center: Water amount
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "${item.amount} ml",
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 14.sp,
                                            fontFamily: 'Urbanist-Medium',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.4.sp,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Right: Status
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            item.status ==
                                                    HydrationStatus.completed
                                                ? Icons.check
                                                : Icons.radio_button_unchecked,
                                            size: 16.sp,
                                            color:
                                                item.status ==
                                                        HydrationStatus
                                                            .completed
                                                    ? Color(0xFFB8FFB2)
                                                    : Color(0xFFFFFAB2),
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            item.status ==
                                                    HydrationStatus.completed
                                                ? "Completed"
                                                : "Pending",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color:
                                                  item.status ==
                                                          HydrationStatus
                                                              .completed
                                                      ? Color(0xFFB8FFB2)
                                                      : Color(0xFFFFFAB2),
                                            ),
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

                    SizedBox(height: 30.h),
                    Container(
                      height: screenHeight * 0.09,
                      margin: EdgeInsets.only(
                        left: screenWidth * 0.0,
                        right: screenWidth * 0.0,
                        //bottom: screenHeight * 0.01,
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
                              // _buildNavItem(
                              //   Icons.home,
                              //   'Home',
                              //   title == 'Home',
                              //   screenWidth,
                              //   screenHeight,
                              // ),
                              NavItemWidget(
                                icon: Icons.home,
                                label: 'Home',
                                isActive: title == 'Home',
                                onTab: () {
                                  setState(() {
                                    title = 'Home';
                                    Navigator.pushNamed(context, '/homepage');
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    title = 'Home';
                                    Navigator.pushNamed(context, '/homepage');
                                  });
                                },
                              ),

                              NavItemWidget(
                                icon: Icons.analytics_outlined,
                                label: 'Analysis',
                                isActive: title == 'Analysis',
                                onTab: () {
                                  setState(() {
                                    title = 'Analysis';
                                    Navigator.pushNamed(context, '/Analysis');
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    title = 'Analysis';
                                    Navigator.pushNamed(context, '/analysis');
                                  });
                                },
                              ),

                              NavItemWidget(
                                icon: Icons.lightbulb_outline,
                                label: 'Goals',
                                isActive: title == 'Goals',
                                onTab: () {
                                  setState(() {
                                    title = 'Goals';
                                    Navigator.pushNamed(
                                      context,
                                      '/achievement',
                                    );
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    title = 'Goals';
                                    Navigator.pushNamed(
                                      context,
                                      '/achievement',
                                    );
                                  });
                                },
                              ),

                              NavItemWidget(
                                icon: Icons.settings,
                                label: 'Settings',
                                isActive: title == 'Settings',
                                onTab: () {
                                  setState(() {
                                    title = 'Settings';
                                    Navigator.pushNamed(
                                      context,
                                      '/profilrscreen',
                                    );
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    title = 'Settings';
                                    Navigator.pushNamed(
                                      context,
                                      '/profilescreen',
                                    );
                                  });
                                },
                              ),

                              // _buildNavItem(
                              //   Icons.analytics_outlined,
                              //   'Analysis',
                              //   title == 'Analysis',
                              //   screenWidth,
                              //   screenHeight,
                              // ),
                              // _buildNavItem(
                              //   Icons.lightbulb_outline,
                              //   'Goals',
                              //   title == 'Goals',
                              //   screenWidth,
                              //   screenHeight,
                              // ),
                              // _buildNavItem(
                              //   Icons.settings,
                              //   'Settings',
                              //   title == 'Settings',
                              //   screenWidth,
                              //   screenHeight,
                              // ),
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
        );
      },
    );
  }

  void _showTimeEditBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        String selectedTimeRange = "7:00-8:00 AM"; // default or from entry

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              //padding: EdgeInsets.all(30.w),
              padding: EdgeInsets.only(
                left: 25.w,
                right: 30.w,
                top: 15.h,
                bottom: 30.h,
              ),
              margin: EdgeInsets.only(top: 100.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB586BE), Color(0xFF131313)],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + close icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Breakfast Time",
                        style: TextStyle(
                          fontFamily: 'Urbanist_SemiBold',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: Colors.white70,
                          size: 22.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Dropdown
                  Text(
                    "Time",
                    style: TextStyle(
                      fontFamily: 'Urbanist_SemiBold',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Color(0x10FFFFFF),
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: Color(0x40FFFFFF)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Color(0xFF2B2B2B),
                        isExpanded: true,
                        value: selectedTimeRange,
                        icon: Image.asset(
                          'assets/drop_down_arrow.png', // your image path
                          width: 15.w, // adjust size
                          height: 15.h,
                          //color: null, // or set color if you want to tint
                        ),
                        style: TextStyle(
                          fontFamily: 'Urbanist_Medium',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFFFFF),
                        ),
                        items:
                            [
                              "7:00-8:00 AM",
                              "8:00-9:00 AM",
                              "9:00-10:00 AM",
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() => selectedTimeRange = newValue!);
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.white,
                            // foregroundColor: Colors.black,
                            backgroundColor:
                                isSelected
                                    ? Color(0xFF2196F3)
                                    : Color(0xFFFFFFFF),
                            foregroundColor:
                                isSelected ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            minimumSize: Size(
                              80.w,
                              50.h,
                            ), // width smaller, height taller
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                            ), // optional for extra height
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontFamily: 'Urbanist-Bold',
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF369FFF),
                              fontSize: 16.sp,
                              letterSpacing: 0.2.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2196F3),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            minimumSize: Size(
                              80.w,
                              50.h,
                            ), // narrower width, taller height
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                            ), // optional extra height
                          ),
                          onPressed: () {
                            // Save selected time range here
                            Navigator.pop(context);
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(
                              fontFamily: 'Urbanist-Bold',
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFFFFFF),
                              fontSize: 16.sp,
                              letterSpacing: 0.2.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //   Widget _buildNavItem(
  //     IconData icon,
  //     String label,
  //     bool isActive,
  //     double screenWidth,
  //     double screenHeight,
  //   ) {
  //     final assetPath = 'assets/${label.toLowerCase()}.png';
  //     double scale = 1.0;

  //     return StatefulBuilder(
  //       builder: (context, setState) {
  //         return GestureDetector(
  //           onTapDown: (_) => setState(() => scale = 0.9),
  //           onTapUp: (_) => setState(() => scale = 1.0),
  //           onTapCancel: () => setState(() => scale = 1.0),
  //           onTap: () {
  //             debugPrint('Tapped on: $label');
  //             _handleBottomNavigation(label);
  //           },
  //           child: AnimatedScale(
  //             scale: scale,
  //             duration: const Duration(milliseconds: 10),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   width: screenWidth * 0.2,
  //                   height: screenHeight * 0.06,
  //                   decoration: BoxDecoration(
  //                     gradient:
  //                         isActive
  //                             ? const LinearGradient(
  //                               colors: [Color(0xFFFAFAFA), Color(0xFF3E3E3E)],
  //                               begin: Alignment.topCenter,
  //                               end: Alignment.bottomCenter,
  //                             )
  //                             : null,
  //                     color: isActive ? null : Colors.transparent,
  //                     borderRadius: BorderRadius.circular(48.r),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         offset: const Offset(4, 4),
  //                         color:
  //                             isActive
  //                                 ? const Color(0x40000000)
  //                                 : Colors.transparent,
  //                         blurRadius: 4,
  //                       ),
  //                     ],
  //                   ),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(1.0),
  //                     child: Container(
  //                       width: screenWidth * 0.19,
  //                       height: screenHeight * 0.055,
  //                       decoration: BoxDecoration(
  //                         gradient:
  //                             isActive
  //                                 ? const LinearGradient(
  //                                   colors: [
  //                                     Color(0xFFB182BA),
  //                                     Color(0xFF2D1B31),
  //                                   ],
  //                                   begin: Alignment.topCenter,
  //                                   end: Alignment.bottomCenter,
  //                                 )
  //                                 : null,
  //                         color: isActive ? null : Colors.transparent,
  //                         borderRadius: BorderRadius.circular(46),
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             assetPath,
  //                             width: screenWidth * 0.06,
  //                             height: screenWidth * 0.06,
  //                             color: Colors.white,
  //                             errorBuilder: (context, error, stackTrace) {
  //                               debugPrint(
  //                                 'Error loading image: $assetPath - $error',
  //                               );
  //                               return Icon(
  //                                 icon,
  //                                 size: screenWidth * 0.055,
  //                                 color: Colors.white,
  //                               );
  //                             },
  //                           ),
  //                           Text(
  //                             label,
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: screenWidth * 0.03,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }

  //   void _handleBottomNavigation(String label) {
  //     setState(() {
  //       title = label; // Update active tab
  //     });

  //     switch (label) {
  //       case 'Home':
  //         Navigator.pushNamed(context, '/homepage');
  //         break;
  //       case 'Analysis':
  //         Navigator.pushNamed(context, '/analysis');
  //         break;
  //       case 'Goals':
  //         Navigator.pushNamed(context, '/achievement');
  //         break;
  //       case 'Settings':
  //         Navigator.pushNamed(context, '/profilescreen');
  //         break;
  //       default:
  //         debugPrint('No route defined for $label');
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(SnackBar(content: Text('$label screen coming soon!')));
  //     }
  //   }
}

class ProgressCircle extends StatelessWidget {
  final int drank;
  final int goal;

  const ProgressCircle({required this.drank, required this.goal, super.key});

  @override
  Widget build(BuildContext context) {
    final double percent = (drank / goal).clamp(0.0, 1.0);

    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: CustomPaint(
        painter: GradientCirclePainter(percent: percent),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$drank ml",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "/$goal ml",
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientCirclePainter extends CustomPainter {
  final double percent;

  GradientCirclePainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 14.0;
    final radius = (size.width / 2) - strokeWidth / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background circle
    final backgroundPaint =
        Paint()
          ..color = Color(0x10FFFFFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Updated 3-color gradient
    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      transform: GradientRotation(-pi / 1.8),
      colors: const [Color(0xFFFFFFFF), Color(0xFF9FDCFF), Color(0xFF3FBAFF)],
      stops: [0.0, percent * 0.6, percent],
    );

    final progressPaint =
        Paint()
          ..shader = gradient.createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -pi / 2, 2 * pi * percent, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant GradientCirclePainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}
