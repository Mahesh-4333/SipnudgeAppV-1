// Updated DrinkReminder.dart with capsule-style Smart Skip and Alarm Repeat list items

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/widgets/custom_bttom_sheet_rm.dart';

class DrinkReminder extends StatefulWidget {
  const DrinkReminder({super.key});

  @override
  State<DrinkReminder> createState() => _DrinkReminderState();
}

class _DrinkReminderState extends State<DrinkReminder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> smartSkipOptions = ['3 mins', '5 mins', '10 mins'];
  final List<String> alarmRepeatOptions = ['3 Times', '5 Times', '10 Times'];

  int smartSkipIndex = 2; // default '10 mins'
  int alarmRepeatIndex = 2; // default '3 Times'

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

  void _showReminderMode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ReminderBottomSheet(context),
    );
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
          child: Column(
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    _buildCard(
                      children: [
                        _buildToggleRow('Reminder', reminderEnabled, (val) {
                          setState(() => reminderEnabled = val);
                        }),
                        _buildListItem('Reminder Mode', reminderMode, () {
                          _showReminderMode(context);
                        }),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildCard(
                      children: [
                        _buildCycleItem(
                          'Smart Skip',
                          smartSkipOptions[smartSkipIndex],
                          () {
                            setState(() {
                              smartSkipIndex =
                                  (smartSkipIndex + 1) %
                                  smartSkipOptions.length;
                              smartSkip = smartSkipOptions[smartSkipIndex];
                            });
                          },
                        ),
                        _buildCycleItem(
                          'Alarm Repeat',
                          alarmRepeatOptions[alarmRepeatIndex],
                          () {
                            setState(() {
                              alarmRepeatIndex =
                                  (alarmRepeatIndex + 1) %
                                  alarmRepeatOptions.length;
                              alarmRepeat =
                                  alarmRepeatOptions[alarmRepeatIndex];
                            });
                          },
                        ),
                        _buildToggleRow('Stop When 100%', stopWhenFull, (val) {
                          setState(() => stopWhenFull = val);
                        }),
                      ],
                    ),
                    SizedBox(height: 16.h),
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
                        _buildListItem('Water Intake Timeline', '', () {
                          Navigator.pushNamed(context, '/waterintaketimeline');
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _buildNavBar(screenHeight, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCycleItem(String title, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: 'Urbanist-SemiBold',
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA).withOpacity(0.25),
                border: Border.all(color: Color(0xFFFFFFFF), width: 1.w),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16.sp,
                  fontFamily: 'Urbanist-SemiBold',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListItem(
    String title,
    String trailing,
    VoidCallback onTap, {
    bool showCapsule = false,
  }) {
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
            if (showCapsule)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Text(
                  trailing,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'Urbanist-Medium',
                  ),
                ),
              )
            else
              Row(
                children: [
                  if (trailing.isNotEmpty)
                    Text(
                      trailing,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Urbanist-SemiBold',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  SizedBox(width: 8.w),
                  IconButton(
                    icon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    onPressed: onTap,
                  ),
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
            activeTrackColor: Color(0xFF6C00C3),
            inactiveTrackColor: Color(0xFFFFFFFF),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar(double screenHeight, double screenWidth) {
    return Container(
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
                            errorBuilder:
                                (context, error, stackTrace) => Icon(
                                  icon,
                                  size: screenWidth * 0.055,
                                  color: Colors.white,
                                ),
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
    setState(() => title = label);

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label screen coming soon!')));
    }
  }
}
