import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrinkReminder extends StatefulWidget {
  const DrinkReminder({super.key});

  @override
  State<DrinkReminder> createState() => _DrinkReminderState();
}

class _DrinkReminderState extends State<DrinkReminder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool reminderEnabled = true;
  bool stopWhenFull = true;

  String reminderMode = 'Static';
  String smartSkip = '10 mins';
  String alarmRepeat = '3 Times';
  String dayStart = '07:00 AM';
  String title = 'Home';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
          //child: SingleChildScrollView(
          //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.06,
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF212121),
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.15),
                    Text(
                      'Drink Reminder',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontFamily: 'urbanist-Bold',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Reminder Card
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16.w,
                  //SSvertical: 6.h,
                ),
                child: Column(
                  children: [
                    _buildCard(
                      children: [
                        _buildToggleRow('Reminder', reminderEnabled, (val) {
                          setState(() => reminderEnabled = val);
                        }),
                        _buildListItem('Reminder Mode', reminderMode, () {
                          // Navigate to Reminder Mode Selection
                        }),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Smart Skip & Alarm Card
                    _buildCard(
                      children: [
                        _buildListItem('Smart Skip', smartSkip, () {
                          // Navigate to Smart Skip settings
                        }),
                        _buildListItem('Alarm Repeat', alarmRepeat, () {
                          // Navigate to Alarm Repeat settings
                        }),
                        _buildToggleRow('Stop When 100%', stopWhenFull, (val) {
                          setState(() => stopWhenFull = val);
                        }),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Reminder Settings
                    _buildCard(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Reminder Settings',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'Urbanist-Bold',
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Colors.white54, thickness: 1.sp),
                        _buildListItem('Day Start', dayStart, () {
                          // Time picker logic
                        }),
                        _buildListItem('Day End', '', () {
                          // Set day end time
                        }),
                        _buildListItem('Water Intake Timeline', '', () {
                          // Navigate to timeline screen
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
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
            ],
          ),
          // ),
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Color(0x20FFFFFF),
        borderRadius: BorderRadius.circular(16.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0x40000000),
        //     offset: Offset(3, 3),
        //     blurRadius: 6.r,
        //   ),
        // ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListItem(String title, String trailing, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20.sp,
                fontFamily: 'Urbanist-SemiBold',
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                if (trailing.isNotEmpty)
                  Text(
                    trailing,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16.sp,
                      fontFamily: 'Urbanist-SemiBold',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2.sp,
                    ),
                  ),
                SizedBox(width: 8.w),
                Icon(Icons.chevron_right, color: Colors.white, size: 20.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20.sp,
              fontFamily: 'Urbanist-SemiBold',
              fontWeight: FontWeight.w600,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFFFFFFFF),
            activeTrackColor: const Color(0xFF6C00C3),
            //inactiveThumbColor: const Color(0x90FFFFFF),
            inactiveTrackColor: Color(0xFFFFFFFF),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
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
